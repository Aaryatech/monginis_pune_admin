
package com.ats.adminpanel.controller;

import java.io.FileOutputStream;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ats.adminpanel.commons.Constants;
import com.ats.adminpanel.commons.VpsImageUpload;
import com.ats.adminpanel.model.ExportToExcel;
import com.ats.adminpanel.model.Info;
import com.ats.adminpanel.model.StockItem;
import com.ats.adminpanel.model.TrayType;
import com.ats.adminpanel.model.RawMaterial.RawMaterialUom;
import com.ats.adminpanel.model.item.AllItemsListResponse;
import com.ats.adminpanel.model.item.CategoryListResponse;
import com.ats.adminpanel.model.item.FrItemStock;
import com.ats.adminpanel.model.item.FrItemStockConfigureList;
import com.ats.adminpanel.model.item.FrItemStockConfigurePost;
import com.ats.adminpanel.model.item.GetItemSup;
import com.ats.adminpanel.model.item.GetPrevItemStockResponse;
import com.ats.adminpanel.model.item.Item;
import com.ats.adminpanel.model.item.ItemSup;
import com.ats.adminpanel.model.item.ItemSupList;
import com.ats.adminpanel.model.item.MCategoryList;
import com.ats.adminpanel.model.item.StockDetail;
import com.ats.adminpanel.model.item.SubCategory;
import com.ats.adminpanel.model.mastexcel.ItemList;
import com.ats.adminpanel.model.mastexcel.TallyItem;
import com.ats.adminpanel.model.modules.ErrorMessage;

@Controller
public class ItemController {

	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);

	AllItemsListResponse allItemsListResponse;

	public static List<MCategoryList> mCategoryList = null;

	public static CategoryListResponse categoryListResponse;

	public static List<MCategoryList> itemsWithCategoriesList;
	public int settingValue;

	public static List<FrItemStockConfigurePost> frItemStockConfigureList;

	ArrayList<Item> itemList;

	public static List<GetPrevItemStockResponse> getPrevItemStockResponsesList;

	ArrayList<String> tempItemList;
	public int catId = 0;
	int suppId;
	int suppCatId;
	String suppItemName;
	boolean isError = false;
	ArrayList<StockItem> tempStockItemList;


	@RequestMapping(value = "/updateHsnAndPer", method = RequestMethod.GET)
	public ModelAndView updateHsnAndPer(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("items/updateHsnPer");

		/*
		 * Constants.mainAct =1; Constants.subAct =4;
		 */
		try {
			RestTemplate restTemplate = new RestTemplate();
			allItemsListResponse = restTemplate.getForObject(Constants.url + "getAllItems", AllItemsListResponse.class);

			List<Item> itemsList = new ArrayList<Item>();
			itemsList = allItemsListResponse.getItems();

			categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			mCategoryList = categoryListResponse.getmCategoryList();
			List<MCategoryList> resCatList = new ArrayList<MCategoryList>();
			for (MCategoryList mCat : mCategoryList) {
				if (mCat.getCatId() != 5 && mCat.getCatId() != 6) {
					resCatList.add(mCat);
				}
			}
			model.addObject("itemsList", itemsList);
			model.addObject("mCategoryList", resCatList);
		} catch (Exception e) {
			System.out.println("" + e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "/updateHsnAndTaxPerc", method = RequestMethod.POST)
	public String updateHsnAndTaxPer(HttpServletRequest request, HttpServletResponse response) {
		try {
			RestTemplate restTemplate = new RestTemplate();

			String[] item = request.getParameterValues("items[]");
			StringBuilder sb = new StringBuilder();
			for (int i = 0; i < item.length; i++) {
				sb = sb.append(item[i] + ",");
			}
			String items = sb.toString();
			items = items.substring(0, items.length() - 1);

			float itemTax1 = Float.parseFloat(request.getParameter("item_tax1"));

			float itemTax2 = Float.parseFloat(request.getParameter("item_tax2"));

			float itemTax3 = Float.parseFloat(request.getParameter("item_tax3"));

			String itemHsncd = request.getParameter("hsn_code");

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("items", items);
			map.add("itemHsncd", itemHsncd);
			map.add("itemTax1", itemTax1);
			map.add("itemTax2", itemTax2);
			map.add("itemTax3", itemTax3);

			Info info = restTemplate.postForObject(Constants.url + "updateItemHsnAndPer", map, Info.class);

			System.err.println(info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}

	@RequestMapping(value = "/addItem", method = RequestMethod.GET)
	public ModelAndView addItem(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("items/addnewitem");

		Constants.mainAct = 1;
		Constants.subAct = 4;
		try {

			System.out.println("Add Item Request");

			RestTemplate restTemplate = new RestTemplate();
			// CategoryListResponse
			categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			mCategoryList = new ArrayList<MCategoryList>();
			mCategoryList = categoryListResponse.getmCategoryList();
			System.out.println("Main Cat is  " + categoryListResponse.toString());
			//Integer maxId = restTemplate.getForObject(Constants.url + "getUniqueItemCode", Integer.class);

			//model.addObject("itemId", maxId);
			model.addObject("mCategoryList", mCategoryList);
			model.addObject("isError", isError);
			isError = false;

		} catch (Exception e) {
			System.out.println("error in item show sachin" + e.getMessage());
		}
		return model;
	}

	@RequestMapping(value = "/getGroup2ByCatId", method = RequestMethod.GET)
	public @ResponseBody List<SubCategory> subCatById(@RequestParam(value = "catId", required = true) int catId) {
		logger.debug("finding Items for menu " + catId);

		List<SubCategory> subCatList = new ArrayList<SubCategory>();
		System.out.println("CatId" + mCategoryList.size());
		for (int x = 0; x < mCategoryList.size(); x++) {
			System.out.println("mCategoryList.get(x).getCatId(" + mCategoryList.get(x).getCatId());
			if (mCategoryList.get(x).getCatId() == catId) {
				subCatList = mCategoryList.get(x).getSubCategoryList();
			}

		}

		return subCatList;
	}

	@RequestMapping(value = "/showFrItemConfiguration")
	public ModelAndView showFrItemConfiguration(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Item Request");
		ModelAndView model = new ModelAndView("items/itemConfig");
		Constants.mainAct = 2;
		Constants.subAct = 13;

		try {

			RestTemplate restTemplate = new RestTemplate();

			/*
			 * FrItemStockConfiResponse frItemStockConfiResponse = restTemplate
			 * .getForObject(Constants.url + "getfrItemConfSetting",
			 * FrItemStockConfiResponse.class);
			 */

			/*
			 * List<FrItemStockConfigure> frItemStockConfigures = new
			 * ArrayList<FrItemStockConfigure>();
			 * 
			 * frItemStockConfigures = frItemStockConfiResponse.getFrItemStockConfigure();
			 * 
			 * for (int i = 0; i < frItemStockConfigures.size(); i++) {
			 * 
			 * if (frItemStockConfigures.get(i).getSettingKey().equals("frItemStockType")) {
			 * 
			 * settingValue = frItemStockConfigures.get(i).getSettingValue();
			 * 
			 * }
			 * 
			 * }
			 * 
			 */
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			String settingKey = "frItemStockType";

			map.add("settingKeyList", settingKey);

			FrItemStockConfigureList settingList = restTemplate.postForObject(Constants.url + "getDeptSettingValue",
					map, FrItemStockConfigureList.class);

			System.out.println("SettingKeyList" + settingList.toString());

			System.out.println("settingValue-------------------------------------------=="
					+ settingList.getFrItemStockConfigure().get(0).getSettingValue());
			settingValue = settingList.getFrItemStockConfigure().get(0).getSettingValue();
			CategoryListResponse itemsWithCategoryResponseList = restTemplate
					.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);

			itemsWithCategoriesList = itemsWithCategoryResponseList.getmCategoryList();

			// System.out.println("item Id Cat Name --" +
			// itemsWithCategoriesList.toString());

			for (int i = 0; i < itemsWithCategoriesList.size(); i++) {

				// System.out.println("cat id== " + itemsWithCategoriesList.get(i).getCatId());
				if (itemsWithCategoriesList.get(i).getCatId() == 5) {

					itemsWithCategoriesList.remove(i);

				}

			}

			for (int i = 0; i < itemsWithCategoriesList.size(); i++) {

				// System.out.println("cat id== " + itemsWithCategoriesList.get(i).getCatId());
				if (itemsWithCategoriesList.get(i).getCatId() == 6) {

					itemsWithCategoriesList.remove(i);

				}

			}

			model.addObject("settingValue", settingValue);
			model.addObject("ItemIdCategory", itemsWithCategoriesList);
			model.addObject("catId", catId);
			model.addObject("itemList", getPrevItemStockResponsesList);

		} catch (Exception e) {

			System.out.println("Exception in showing fr Item Stock Confi " + e.getMessage());
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(value = "/showFrItemConfP")
	public ModelAndView showFrItemConfP(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("items/itemConfP");
		Constants.mainAct = 2;
		Constants.subAct = 13;

		try {
		
			model.addObject("catId", catId);
			model.addObject("itemList", tempItemList);

		} catch (Exception e) {

			e.printStackTrace();
		}
		return model;
	}


	@RequestMapping(value = "/getItemsbySubCatId", method = RequestMethod.POST)
	public ModelAndView getItemsbySubCatId(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemConfP");
		try {

			catId = Integer.parseInt(request.getParameter("cat_name"));

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("subCatId", catId);
			map.add("type", 8);
			RestTemplate restTemplate = new RestTemplate();

			StockItem[] item = restTemplate.postForObject(Constants.url + "getStockItemsBySubCatId", map,
					StockItem[].class);

			tempStockItemList = new ArrayList<StockItem>(Arrays.asList(item));

			model.addObject("itemList", tempStockItemList);
			model.addObject("catId", catId);

		} catch (Exception e) {

			System.out.println("exe in item get By CatId frItemConf " + e.getMessage());
			e.printStackTrace();
		}

		return model;

	}

	@RequestMapping(value = "/getItemsbyCatIdProcess", method = RequestMethod.GET)
	public String getItemsbyCatIdProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemConfig");
		try {

			String catIds = request.getParameter("cat_name");
			if (catIds == null || catIds == "") {
				catId = catId;
			} else {
				catId = Integer.parseInt(catIds);
			}
			System.out.println("cat Id " + catId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

			// MultiValueMap<String, Object> mapItemList = new LinkedMultiValueMap<String,
			// Object>();

			map.add("itemGrp1", catId);

			RestTemplate restTemplate = new RestTemplate();

			Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatId", map, Item[].class);

			ArrayList<Item> tempItemList = new ArrayList<Item>(Arrays.asList(item));

			StringBuilder stringBuilder = new StringBuilder();

			String itemId;

			for (int i = 0; i < tempItemList.size(); i++) {

				itemId = (tempItemList.get(i).getId()) + ",";
				stringBuilder.append(itemId);

			}

			String itemIds = stringBuilder.toString();
			itemIds = itemIds.substring(0, itemIds.length() - 1);

			System.out.println("itemId :" + itemIds);

			map = new LinkedMultiValueMap<String, Object>();

			map.add("itemId", itemIds);

			getPrevItemStockResponsesList = new ArrayList<GetPrevItemStockResponse>();

			ParameterizedTypeReference<List<GetPrevItemStockResponse>> typeRef = new ParameterizedTypeReference<List<GetPrevItemStockResponse>>() {
			};

			ResponseEntity<List<GetPrevItemStockResponse>> responseEntity = restTemplate
					.exchange(Constants.url + "getAllFrItemConfPost", HttpMethod.POST, new HttpEntity<>(map), typeRef);

			getPrevItemStockResponsesList = responseEntity.getBody();

			if (getPrevItemStockResponsesList.size() < tempItemList.size()) {

				List<GetPrevItemStockResponse> tempPrevItemStockList = new ArrayList<GetPrevItemStockResponse>();

				for (int i = 0; i < tempItemList.size(); i++) {

					Item tempItem = tempItemList.get(i);

					GetPrevItemStockResponse tempItemStockResponse = new GetPrevItemStockResponse();

					tempItemStockResponse.setItemId(tempItem.getId());
					tempItemStockResponse.setItemName(tempItem.getItemName());

					List<StockDetail> stockDetailsList = new ArrayList<StockDetail>();

					for (int j = 1; j <= settingValue; j++) {

						StockDetail stockDetail = new StockDetail();

						stockDetail.setFrStockId(0);
						stockDetail.setMaxQty(0);
						stockDetail.setMinQty(0);
						stockDetail.setType(j);
						stockDetail.setReorderQty(0);
						stockDetailsList.add(stockDetail);

					}

					tempItemStockResponse.setStockDetails(stockDetailsList);

					for (int j = 0; j < getPrevItemStockResponsesList.size(); j++) {

						if (getPrevItemStockResponsesList.get(j).getItemId() == tempItemList.get(i).getId()) {

							tempItemStockResponse = getPrevItemStockResponsesList.get(j);
						}

					}

					tempPrevItemStockList.add(tempItemStockResponse);

				}

				System.out.println("\n\n ####### Updated Stock List is: " + tempPrevItemStockList.toString());

				getPrevItemStockResponsesList = new ArrayList<GetPrevItemStockResponse>();

				getPrevItemStockResponsesList = tempPrevItemStockList;
			}

			itemList = new ArrayList<Item>(Arrays.asList(item));

			System.out.println(" item Stock response  List " + getPrevItemStockResponsesList.toString());
			System.out.println("item list size= " + getPrevItemStockResponsesList.size());

			model.addObject("catId", catId);
			model.addObject("itemList", getPrevItemStockResponsesList);

		} catch (Exception e) {

			System.out.println("exe in item get By CatId frItemConf " + e.getMessage());
			e.printStackTrace();
		}

		return "redirect:/showFrItemConfiguration";

	}

	@RequestMapping(value = "/frItemStockConfInsert", method = RequestMethod.POST)
	public String frItemStockConfInsert(HttpServletRequest request, HttpServletResponse response) {

		List<FrItemStock> frItemStocksList = new ArrayList<FrItemStock>();
		try {
			RestTemplate rest = new RestTemplate();

			if (tempStockItemList.size() > 0) {

				for (int i = 0; i < tempStockItemList.size(); i++) {

					StockItem stockItemRes = tempStockItemList.get(i);

					String minQty = request.getParameter(stockItemRes.getId() + "min" + i);
					String maxQty = request.getParameter(stockItemRes.getId() + "max" + i);
					String reorderQty = request.getParameter(stockItemRes.getId() + "reorder" + i);
					if (Integer.parseInt(maxQty) > 0) {
						FrItemStock frItemStock = new FrItemStock();
						frItemStock.setFrStockId(stockItemRes.getFrStockId());
						frItemStock.setMinQty(Integer.parseInt(minQty));
						frItemStock.setMaxQty(Integer.parseInt(maxQty));
						frItemStock.setReorderQty(Integer.parseInt(reorderQty));
						frItemStock.setItemId(stockItemRes.getId());
						frItemStock.setType(8);
						frItemStocksList.add(frItemStock);
					}

				}
			}

			System.out.println("Fr item Stock " + frItemStocksList.toString());
			System.out.println("fr item stock size " + frItemStocksList.size());

			ErrorMessage errorResponse = rest.postForObject(Constants.url + "frItemStockPost", frItemStocksList,
					ErrorMessage.class);

		} catch (Exception e) {

			System.out.println("exe in fr Item  stock insert  process  " + e.getMessage());

			e.printStackTrace();
		}

		return "redirect:/showFrItemConfP";

	}

	@RequestMapping(value = "/frItemStockConfigurationProcess", method = RequestMethod.POST)
	public String frItemStockInsertProcess(HttpServletRequest request, HttpServletResponse response) {
		// ModelAndView mav = new ModelAndView("items/itemlist");

		List<FrItemStock> frItemStocksList = new ArrayList<FrItemStock>();

		try {

			RestTemplate rest = new RestTemplate();

			// catId = Integer.parseInt(request.getParameter("cat_name"));

			for (int i = 0; i < getPrevItemStockResponsesList.size(); i++) {

				GetPrevItemStockResponse getPrevItemStockResponse = getPrevItemStockResponsesList.get(i);

				for (int j = 0; j < getPrevItemStockResponse.getStockDetails().size(); j++) {

					FrItemStock frItemStock = new FrItemStock();
					StockDetail stockDetail = getPrevItemStockResponse.getStockDetails().get(j);

					// ${item.itemId}stockId${count.index}

					String frStockId = request.getParameter("" + getPrevItemStockResponse.getItemId() + "stockId" + j);
					String minQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "min" + j);

					String maxQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "max" + j);
					String reorderQty = request.getParameter("" + getPrevItemStockResponse.getItemId() + "reorder" + j);

					System.out.println("min Qty = " + minQty);
					System.out.println("max Qty = " + maxQty);
					System.out.println("reorder Qty = " + reorderQty);

					if (!minQty.equalsIgnoreCase("") && minQty != null && !maxQty.equalsIgnoreCase("") && maxQty != null
							&& !reorderQty.equalsIgnoreCase("") && reorderQty != null) {

						if (Integer.parseInt(minQty) != stockDetail.getMinQty()
								|| Integer.parseInt(maxQty) != stockDetail.getMaxQty()
								|| Integer.parseInt(reorderQty) != stockDetail.getReorderQty()) {

							frItemStock.setFrStockId(Integer.parseInt(frStockId));
							frItemStock.setMinQty(Integer.parseInt(minQty));

							frItemStock.setMaxQty(Integer.parseInt(maxQty));

							frItemStock.setReorderQty(Integer.parseInt(reorderQty));

							frItemStock.setItemId(getPrevItemStockResponse.getItemId());
							frItemStock.setType(j + 1);
							frItemStocksList.add(frItemStock);

						}
					}

				}
			}

			System.out.println("Fr item Stock " + frItemStocksList.toString());
			System.out.println("fr item stock size " + frItemStocksList.size());

			ErrorMessage errorResponse = rest.postForObject(Constants.url + "frItemStockPost", frItemStocksList,
					ErrorMessage.class);

		} catch (Exception e) {

			System.out.println("exe in fr Item  stock insert  process  " + e.getMessage());

			e.printStackTrace();
		}

		return "redirect:/getItemsbyCatIdProcess";

	}

	@RequestMapping(value = "/addItemProcess", method = RequestMethod.POST)
	public String addItemProcess(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("item_image") List<MultipartFile> file) {
		ModelAndView mav = new ModelAndView("items/itemlist");

		String itemId = request.getParameter("item_id");

		int minQty = Integer.parseInt(request.getParameter("min_qty"));

		String itemName = request.getParameter("item_name");

		String itemGrp1 = request.getParameter("item_grp1");

		String itemGrp2 = request.getParameter("item_grp2");

		String itemGrp3 = request.getParameter("item_grp3");

		double itemRate1 = Double.parseDouble(request.getParameter("item_rate1"));

		double itemRate2 = Double.parseDouble(request.getParameter("item_rate2"));

		double itemRate3 = Double.parseDouble(request.getParameter("item_rate3"));

		double itemMrp1 = Double.parseDouble(request.getParameter("item_mrp1"));

		double itemMrp2 = Double.parseDouble(request.getParameter("item_mrp2"));

		double itemMrp3 = Double.parseDouble(request.getParameter("item_mrp3"));

		// String itemImage = request.getParameter("item_image");

		double itemTax1 = Double.parseDouble(request.getParameter("item_tax1"));

		double itemTax2 = Double.parseDouble(request.getParameter("item_tax2"));

		double itemTax3 = Double.parseDouble(request.getParameter("item_tax3"));

		int itemIsUsed = Integer.parseInt(request.getParameter("is_used"));

		String itemSortId = request.getParameter("item_sort_id");

		int grnTwo = Integer.parseInt(request.getParameter("grn_two"));

		int itemShelfLife = Integer.parseInt(request.getParameter("item_shelf_life"));

		logger.info("Add new item request mapping.");

		// String itemImage = ImageS3Util.uploadItemImage(file);

		VpsImageUpload upload = new VpsImageUpload();

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());

		Date date = new Date();

		System.out.println(sdf.format(cal.getTime()));

		String curTimeStamp = sdf.format(cal.getTime());

		/*try {

			upload.saveUploadedFiles(file, Constants.ITEM_IMAGE_TYPE,
					curTimeStamp + "-" + file.get(0).getOriginalFilename());
			// upload.saveUploadedFiles(file, Constants.ITEM_IMAGE_TYPE, itemName);
			System.out.println("upload method called " + file.toString());

		} catch (IOException e) {

			System.out.println("Exce in File Upload In Item Insert " + e.getMessage());
			e.printStackTrace();
		}*/
		RestTemplate rest = new RestTemplate();
        try {
			
		    LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
		    String tempFileName;
		    FileOutputStream fo;

		            tempFileName = curTimeStamp + "-" + file.get(0).getOriginalFilename();
		            fo = new FileOutputStream(tempFileName);
		            fo.write(file.get(0).getBytes());
		            fo.close();
		            map.add("file", new FileSystemResource(tempFileName));
		            map.add("imageName", tempFileName);
					map.add("type", "item");
		        HttpHeaders headers = new HttpHeaders();
		        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

		        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
		        Info infoRes = rest.postForObject(Constants.url + "/photoUpload", requestEntity, Info.class);

	
	     }catch (Exception e) {
	     	e.printStackTrace();
	     }
		
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();

		map.add("itemId", itemId);
		map.add("itemName", itemName);
		map.add("itemGrp1", itemGrp1);
		map.add("itemGrp2", itemGrp2);
		map.add("itemGrp3", itemGrp3);
		map.add("minQty", minQty);
		map.add("itemRate1", itemRate1);
		map.add("itemRate2", itemRate2);
		map.add("itemRate3", itemRate3);
		map.add("itemMrp1", itemMrp1);
		map.add("itemMrp2", itemMrp2);
		map.add("itemMrp3", itemMrp3);
		map.add("itemImage",curTimeStamp+"-"+file.get(0).getOriginalFilename());
		map.add("itemTax1", itemTax1);
		map.add("itemTax2", itemTax2);
		map.add("itemTax3", itemTax3);
		map.add("itemIsUsed", itemIsUsed);

		map.add("itemSortId", itemSortId);
		map.add("grnTwo", grnTwo);
		map.add("itemShelfLife", itemShelfLife);
		try {
			Item itemRes = rest.postForObject("" + Constants.url + "insertItem", map, Item.class);

			if (itemRes != null) {
				isError = false;

				suppId = itemRes.getId();
				suppCatId = Integer.parseInt(itemGrp1);
				suppItemName = itemRes.getItemName();
				return "redirect:/showAddItemSup";
			} else {
				isError = true;
				return "redirect:/addItem";
			}

		} catch (Exception e) {
			isError = true;
			return "redirect:/addItem";

		}

	}

	@RequestMapping(value = "/itemList")
	public ModelAndView showAddItem(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("List Item Request");
		ModelAndView mav = new ModelAndView("items/itemlist");
		Constants.mainAct = 1;
		Constants.subAct = 5;

		RestTemplate restTemplate = new RestTemplate();
		// CategoryListResponse
		categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);
		List<MCategoryList> mCategoryList = new ArrayList<MCategoryList>();
		mCategoryList = categoryListResponse.getmCategoryList();

		mav.addObject("mCategoryList", mCategoryList);
		try {

			// RestTemplate restTemplate = new RestTemplate();
			allItemsListResponse = restTemplate.getForObject(Constants.url + "getAllItems", AllItemsListResponse.class);

			List<Item> itemsList = new ArrayList<Item>();
			itemsList = allItemsListResponse.getItems();
			System.out.println("LIst of items" + itemsList.toString());

			mav.addObject("mCategoryList", mCategoryList);
			mav.addObject("itemsList", itemsList);
			mav.addObject("url", Constants.ITEM_IMAGE_URL);

			// exportToExcel

			ItemList itemResponse = restTemplate.getForObject(Constants.url + "tally/getAllExcelItems", ItemList.class);

			List<ExportToExcel> exportToExcelList = new ArrayList<ExportToExcel>();

			ExportToExcel expoExcel = new ExportToExcel();
			List<String> rowData = new ArrayList<String>();

			rowData.add("Sr. No.");
			rowData.add("Id");
			rowData.add("Item Code");
			rowData.add("Item Name");
			rowData.add("Category");
			rowData.add("Group1");
			rowData.add("Group2");
			rowData.add("HsnCode");
			rowData.add("UOM");
			rowData.add("Rate1");
			rowData.add("Rate2");
			rowData.add("Rate3");
			rowData.add("Mrp1");
			rowData.add("Mrp2");
			rowData.add("Mrp3");
			rowData.add("Sgst %");
			rowData.add("Cgst %");
			rowData.add("Igst %");
			rowData.add("Cess %");

			expoExcel.setRowData(rowData);
			exportToExcelList.add(expoExcel);
			List<TallyItem> excelItems = itemResponse.getItemList();
			for (int i = 0; i < excelItems.size(); i++) {
				expoExcel = new ExportToExcel();
				rowData = new ArrayList<String>();
				rowData.add("" + (i + 1));
				rowData.add("" + excelItems.get(i).getId());
				rowData.add(excelItems.get(i).getItemCode());
				rowData.add(excelItems.get(i).getItemName());
				rowData.add(excelItems.get(i).getItemGroup());
				rowData.add(excelItems.get(i).getSubGroup());
				rowData.add(excelItems.get(i).getSubSubGroup());
				rowData.add(excelItems.get(i).getHsnCode());

				rowData.add(excelItems.get(i).getUom());
				rowData.add("" + excelItems.get(i).getItemRate1());
				rowData.add("" + excelItems.get(i).getItemRate2());
				rowData.add("" + excelItems.get(i).getItemRate3());
				rowData.add("" + excelItems.get(i).getItemRate1());
				rowData.add("" + excelItems.get(i).getItemRate2());
				rowData.add("" + excelItems.get(i).getItemRate3());
				rowData.add("" + excelItems.get(i).getSgstPer());
				rowData.add("" + excelItems.get(i).getCgstPer());
				rowData.add("" + excelItems.get(i).getIgstPer());
				rowData.add("" + excelItems.get(i).getCessPer());

				expoExcel.setRowData(rowData);
				exportToExcelList.add(expoExcel);

			}

			HttpSession session = request.getSession();
			session.setAttribute("exportExcelList", exportToExcelList);
			session.setAttribute("excelName", "itemsList");
			
		List<ExportToExcel>	exportExcelListDummy = new ArrayList<ExportToExcel>();

			 expoExcel = new ExportToExcel();
			 rowData = new ArrayList<String>();

			rowData.add("Item Id");
			rowData.add("Item Name");
			rowData.add("ItemGroup");
			rowData.add("SubGroup");
			rowData.add("SubSubGroup");
			rowData.add("Rate1");
			rowData.add("Rate2");
			rowData.add("Rate3");
			rowData.add("Mrp1");
			rowData.add("Mrp2");
			rowData.add("Mrp3");
			rowData.add("Sgst %");
			rowData.add("Cgst %");
			rowData.add("Igst %");
			rowData.add("Sort Id");
			rowData.add("Is Grn2 App?(1/0)");
			rowData.add("Min Qty");
			rowData.add("Item Shelf Life");

			expoExcel.setRowData(rowData);
			exportExcelListDummy.add(expoExcel);
	

			session.setAttribute("exportExcelListDummy", exportExcelListDummy);
			session.setAttribute("excelName", "ItemExcelImportFormat");
			
		} catch (Exception e) {
			System.out.println("exce in listing filtered group itme" + e.getMessage());
		}

		return mav;

	}
	@RequestMapping(value = "/uploadItemsByFile", method = RequestMethod.POST)
	public String uploadItemsByFile(Model model,@RequestParam("file") MultipartFile excelfile,
			HttpServletRequest request, HttpServletResponse response) {


		try {


			System.out.println("Excel File name " + excelfile.getOriginalFilename());

			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(excelfile.getInputStream());
			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);
			// Reads the data in excel file until last row is encountered

			List<Item>  itemListRes = new ArrayList<Item>();

			System.out.println("Last Row Number is " + worksheet.getLastRowNum());

			for (int i=1; i <= worksheet.getLastRowNum();i++) {
				// Creates an object for the UserInfo Model
				
				Item item = new Item();

				// Creates an object representing a single row in excel
				XSSFRow row = worksheet.getRow(i);
				
				//System.err.println("row = " +row.toString());
				// Sets the Read data to the model class
				// user.setId((int) row.getCell(0).getNumericCellValue());
				try {
				item.setId(0);
			
				item.setItemId(getCellValueAsString(row.getCell(0)));

				item.setItemName(getCellValueAsString(row.getCell(1)));

				item.setItemGrp1(Integer.parseInt(getCellValueAsString(row.getCell(2))));

				item.setItemGrp2(Integer.parseInt(getCellValueAsString(row.getCell(3))));

				item.setItemGrp3(Integer.parseInt(getCellValueAsString(row.getCell(4))));

				item.setItemRate1(Float.parseFloat(getCellValueAsString(row.getCell(5))));

				item.setItemRate2(Float.parseFloat(getCellValueAsString(row.getCell(6))));

				item.setItemRate3(Float.parseFloat(getCellValueAsString(row.getCell(7))));

				item.setItemMrp1(Float.parseFloat(getCellValueAsString(row.getCell(8))));
				
				item.setItemMrp2(Float.parseFloat(getCellValueAsString(row.getCell(9))));
				
				item.setItemMrp3(Float.parseFloat(getCellValueAsString(row.getCell(10))));

				item.setItemTax1(Float.parseFloat(getCellValueAsString(row.getCell(11))));
				
				item.setItemTax2(Float.parseFloat(getCellValueAsString(row.getCell(12))));
				
				item.setItemTax3(Float.parseFloat(getCellValueAsString(row.getCell(13))));
				
				item.setItemSortId(Float.parseFloat(getCellValueAsString(row.getCell(14))));
				
				item.setGrnTwo(Integer.parseInt(getCellValueAsString(row.getCell(15))));
				item.setMinQty(Integer.parseInt(getCellValueAsString(row.getCell(16))));
				
				item.setShelfLife(Integer.parseInt(getCellValueAsString(row.getCell(17))));
				item.setDelStatus(0);
				item.setItemImage("");
				
				itemListRes.add(item);
				}catch (Exception e) {
					// TODO: handle exception
				}
			}
			workbook.close();

			// userService.addListUser(lstUser);

			// model.addAttribute("bean", bean);

			System.out.println("Excel File Arraylist " + itemListRes.toString());
			System.out.println("Excel File Arraylist Size: " + itemListRes.size());

			RestTemplate rest = new RestTemplate();
			List<Item> info = rest.postForObject(Constants.url + "/insertItemList", itemListRes, List.class);
			System.out.println("Response " + info.toString());

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/itemList";

	}public static String getCellValueAsString(Cell cell) {
        String strCellValue = null;
        if (cell != null) {
            switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING:
                strCellValue = cell.toString();
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat(
                            "dd/MM/yyyy");
                    strCellValue = dateFormat.format(cell.getDateCellValue());
                } else {
                    Double value = cell.getNumericCellValue();
                    Long longValue = value.longValue();
                    strCellValue = new String(longValue.toString());
                }
                break;
            case Cell.CELL_TYPE_BOOLEAN:
                strCellValue = new String(new Boolean(
                        cell.getBooleanCellValue()).toString());
                break;
            case Cell.CELL_TYPE_BLANK:
                strCellValue = "";
                break;
            }
        }
        return strCellValue;
    }
	@RequestMapping(value = "/searchItem")
	public ModelAndView showSearchItem(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("List Item Request");

		int catId = Integer.parseInt(request.getParameter("catId"));
		ModelAndView mav = new ModelAndView("items/itemlist");

		RestTemplate restTemplate = new RestTemplate();
		categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);
		// mCategoryList = new ArrayList<MCategoryList>();
		List<MCategoryList> mCategoryList = categoryListResponse.getmCategoryList();

		try {

			List<Item> tempItemsList = new ArrayList<Item>();
			List<Item> itemsList = new ArrayList<Item>();
			itemsList = allItemsListResponse.getItems();

			System.out.println("item count before" + itemsList.size());

			System.out.println("item to show m cat is " + catId);
			for (int i = 0; i < itemsList.size(); i++) {

				if (itemsList.get(i).getItemGrp1() == catId) {
					tempItemsList.add(itemsList.get(i));

				}

			}

			System.out.println("after filter itemList " + tempItemsList.toString());

			mav.addObject("catId", catId);
			mav.addObject("mCategoryList", mCategoryList);
			mav.addObject("itemsList", tempItemsList);

			mav.addObject("url", Constants.ITEM_IMAGE_URL);
		} catch (Exception e) {
			System.out.println("exce in listing filtered group itme" + e.getMessage());
		}

		return mav;

	}

	@RequestMapping(value = "/deleteItem/{idList}", method = RequestMethod.GET)
	public String deleteItem(@PathVariable String[] idList) {

		// String id=request.getParameter("id");
		try {
			ModelAndView mav = new ModelAndView("items/itemList");

			RestTemplate rest = new RestTemplate();

			String strItemIds = new String();
			for (int i = 0; i < idList.length; i++) {
				strItemIds = strItemIds + "," + idList[i];
			}
			strItemIds = strItemIds.substring(1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", strItemIds);

			ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "deleteItem", map, ErrorMessage.class);
			System.out.println(errorResponse.toString());

			Info info = rest.postForObject("" + Constants.url + "deleteItemSup", map, Info.class);
			System.out.println(info.toString());

			if (errorResponse.getError()) {
				return "redirect:/itemList";

			} else {
				return "redirect:/itemList";

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}

	@RequestMapping(value = "/inactiveItem/{idList}", method = RequestMethod.GET)
	public String inactiveItem(@PathVariable String[] idList) {

		// String id=request.getParameter("id");
		try {
			ModelAndView mav = new ModelAndView("items/itemList");

			RestTemplate rest = new RestTemplate();

			String strItemIds = new String();
			for (int i = 0; i < idList.length; i++) {
				strItemIds = strItemIds + "," + idList[i];
			}
			strItemIds = strItemIds.substring(1);
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", strItemIds);

			ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "inactivateItems", map,
					ErrorMessage.class);
			System.out.println(errorResponse.toString());

			if (errorResponse.getError()) {
				return "redirect:/itemList";

			} else {
				return "redirect:/itemList";

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/itemList";
	}

	@RequestMapping(value = "/updateItem/{id}", method = RequestMethod.GET)
	public ModelAndView updateMessage(@PathVariable int id) {
		ModelAndView mav = new ModelAndView("items/editItem");

		RestTemplate restTemplate = new RestTemplate();
		// CategoryListResponse
		categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory", CategoryListResponse.class);
		mCategoryList = new ArrayList<MCategoryList>();
		mCategoryList = categoryListResponse.getmCategoryList();
		System.out.println("Main Cat is  " + categoryListResponse.toString());

		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("id", id);

		Item item = restTemplate.postForObject("" + Constants.url + "getItem", map, Item.class);
		System.out.println("ItemResponse" + item);
		// String grp1 = item.getItemGrp1();
		mav.addObject("grp1", item.getItemGrp1());

		// String grp2 = item.getItemGrp2();
		// System.out.println("GrP 2=#### " + grp2);
		// mav.addObject(" grp2 id",grp2);

		mav.addObject("mCategoryList", mCategoryList);

		List<SubCategory> subCategoryList = new ArrayList<SubCategory>();

		for (int i = 0; i < mCategoryList.size(); i++) {
			if (item.getItemGrp1() == (mCategoryList.get(i).getCatId()))
				subCategoryList = mCategoryList.get(i).getSubCategoryList();

		}

		String selectedItem = "";
		int selectedItemId = 0;
		System.out.println("sub cat list is =" + subCategoryList.toString());
		for (int i = 0; i < subCategoryList.size(); i++) {

			if (subCategoryList.get(i).getSubCatId() == item.getItemGrp2()) {

				selectedItem = subCategoryList.get(i).getSubCatName();
				selectedItemId = subCategoryList.get(i).getSubCatId();

				subCategoryList.remove(i);

			}

		}
		System.out.println("Removed item $$$$$ " + selectedItem);

		mav.addObject("selectedItem", selectedItem);
		mav.addObject("selectedItemId", String.valueOf(selectedItemId));
		mav.addObject("subCategoryList", subCategoryList);

		int grn2app = item.getGrnTwo();
		String strGrnAppl = String.valueOf(grn2app);
		mav.addObject("strGrnAppl", strGrnAppl);

		int isUsed = item.getItemIsUsed();
		String strIsUsed = String.valueOf(isUsed);
		mav.addObject("strIsUsed", strIsUsed);

		mav.addObject("item", item);
		mav.addObject("url", Constants.ITEM_IMAGE_URL);

		int itemGrp3 = item.getItemGrp3();
		mav.addObject("itemGrp3", String.valueOf(itemGrp3));

		return mav;

	}

	@RequestMapping(value = "/updateItem/updateItemProcess", method = RequestMethod.POST)

	public String updateMessage(HttpServletRequest request, HttpServletResponse response,
			@RequestParam("item_image") List<MultipartFile> file) {
		System.out.println("HI");

		ModelAndView model = new ModelAndView("items/itemList");

		RestTemplate restTemplate = new RestTemplate();
		String itemId = request.getParameter("item_id");

		int minQty = Integer.parseInt(request.getParameter("min_qty"));

		String itemName = request.getParameter("item_name");

		String itemGrp1 = request.getParameter("item_grp1");

		String itemGrp2 = request.getParameter("item_grp2");

		String itemGrp3 = request.getParameter("item_grp3");

		double itemRate1 = Double.parseDouble(request.getParameter("item_rate1"));

		double itemRate2 = Double.parseDouble(request.getParameter("item_rate2"));

		double itemRate3 = Double.parseDouble(request.getParameter("item_rate3"));

		double itemMrp1 = Double.parseDouble(request.getParameter("item_mrp1"));

		double itemMrp2 = Double.parseDouble(request.getParameter("item_mrp2"));

		double itemMrp3 = Double.parseDouble(request.getParameter("item_mrp3"));

		/*
		 * String itemImage = request.getParameter("item_image");
		 */
		double itemTax1 = Double.parseDouble(request.getParameter("item_tax1"));

		double itemTax2 = Double.parseDouble(request.getParameter("item_tax2"));

		double itemTax3 = Double.parseDouble(request.getParameter("item_tax3"));

		int itemIsUsed = Integer.parseInt(request.getParameter("is_used"));

		double itemSortId = Double.parseDouble(request.getParameter("item_sort_id"));

		int grnTwo = Integer.parseInt(request.getParameter("grn_two"));
		int id = Integer.parseInt(request.getParameter("itemId"));
		int shelfLife = Integer.parseInt(request.getParameter("item_shelf_life"));

		logger.info("Add new item request mapping.");
		RestTemplate rest = new RestTemplate();
		String itemImage = request.getParameter("prevImage");

		if (!file.get(0).getOriginalFilename().equalsIgnoreCase("")) {
			itemImage = null;

			VpsImageUpload upload = new VpsImageUpload();

			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
			System.out.println(sdf.format(cal.getTime()));

			String curTimeStamp = sdf.format(cal.getTime());
			itemImage = curTimeStamp + "-" + file.get(0).getOriginalFilename();
			/*try {
				itemImage = curTimeStamp + "-" + file.get(0).getOriginalFilename();
				upload.saveUploadedFiles(file, Constants.ITEM_IMAGE_TYPE,
						curTimeStamp + "-" + file.get(0).getOriginalFilename());
				System.out.println("upload method called " + file.toString());

			} catch (IOException e) {

				System.out.println("Exce in File Upload In Item Update " + e.getMessage());
				e.printStackTrace();
			}*/
			 try {	
				    LinkedMultiValueMap<String, Object> map = new LinkedMultiValueMap<>();
				    String tempFileName;
				    FileOutputStream fo;

				       tempFileName = curTimeStamp + "-" + file.get(0).getOriginalFilename();
				       fo = new FileOutputStream(tempFileName);
				       fo.write(file.get(0).getBytes());
				       fo.close();
				       map.add("file", new FileSystemResource(tempFileName));
				       map.add("imageName", tempFileName);
					   map.add("type", "item");
				        HttpHeaders headers = new HttpHeaders();
				        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

				        HttpEntity<LinkedMultiValueMap<String, Object>> requestEntity = new HttpEntity<>(map, headers);
				        Info infoRes = rest.postForObject(Constants.url + "/photoUpload", requestEntity, Info.class);

			
			     }catch (Exception e) {
			     	e.printStackTrace();
			     }
		}
		MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
		map.add("itemId", itemId);
		map.add("itemName", itemName);
		map.add("itemGrp1", itemGrp1);
		map.add("itemGrp2", itemGrp2);
		map.add("itemGrp3", itemGrp3);
		map.add("itemRate1", itemRate1);
		map.add("itemRate2", itemRate2);
		map.add("itemRate3", itemRate3);
		map.add("minQty", minQty);
		map.add("itemMrp1", itemMrp1);
		map.add("itemMrp2", itemMrp2);
		map.add("itemMrp3", itemMrp3);
		map.add("itemImage", itemImage);
		map.add("itemTax1", itemTax1);
		map.add("itemTax2", itemTax2);
		map.add("itemTax3", itemTax3);
		map.add("itemIsUsed", itemIsUsed);
		map.add("itemSortId", itemSortId);
		map.add("grnTwo", grnTwo);
		map.add("id", id);

		map.add("itemShelfLife", shelfLife);
		ErrorMessage errorResponse = rest.postForObject("" + Constants.url + "updateItem", map, ErrorMessage.class);

		return "redirect:/itemList";

	}

	@RequestMapping(value = "/showAddItemSup", method = RequestMethod.GET)
	public ModelAndView showAddItemSup(HttpServletRequest request, HttpServletResponse response) {
		Constants.mainAct = 1;
		Constants.subAct = 109;
		ModelAndView model = new ModelAndView("items/itemSup");
		try {
			RestTemplate restTemplate = new RestTemplate();

			categoryListResponse = restTemplate.getForObject(Constants.url + "showAllCategory",
					CategoryListResponse.class);
			mCategoryList = categoryListResponse.getmCategoryList();
			List<MCategoryList> resCatList = new ArrayList<MCategoryList>();
			for (MCategoryList mCat : mCategoryList) {
				if (mCat.getCatId() != 5 && mCat.getCatId() != 6) {
					resCatList.add(mCat);
				}
			}
			List<RawMaterialUom> rawMaterialUomList = restTemplate.getForObject(Constants.url + "rawMaterial/getRmUom",
					List.class);
			model.addObject("rmUomList", rawMaterialUomList);
			List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);
			System.out.println("Tray Types:" + trayTypeList.toString());
			model.addObject("trayTypes", trayTypeList);

			model.addObject("mCategoryList", resCatList);
			model.addObject("isEdit", 0);
			model.addObject("suppCatId", suppCatId);
			model.addObject("suppId", suppId);
			model.addObject("suppItemName", suppItemName);
			suppCatId = 0;
			suppId = 0;
			suppItemName = "";
		} catch (Exception e) {
			System.out.println("Excption In /showAddItemSup");
		}
		return model;

	}

	@RequestMapping(value = "/getItemsByCatId", method = RequestMethod.GET)
	public @ResponseBody List<Item> getItemsByCatId(HttpServletRequest request, HttpServletResponse response) {

		ArrayList<Item> itemsList = new ArrayList<Item>();
		try {
			int catId = Integer.parseInt(request.getParameter("cat_id"));
			System.out.println("cat Id " + catId);

			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("itemGrp1", catId);

			RestTemplate restTemplate = new RestTemplate();

			Item[] item = restTemplate.postForObject(Constants.url + "getItemsByCatIdForSup", map, Item[].class);

			itemsList = new ArrayList<Item>(Arrays.asList(item));

		} catch (Exception e) {
			System.out.println("Exception in /AJAX getItemsByCatId");
		}
		return itemsList;
	}

	@RequestMapping(value = "/showItemSupList", method = RequestMethod.GET)
	public ModelAndView itemSupList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("items/itemSupList");
		Constants.mainAct = 1;
		Constants.subAct = 110;

		RestTemplate restTemplate = new RestTemplate();

		try {
			ItemSupList itemSupList = restTemplate.getForObject(Constants.url + "/getItemSupList", ItemSupList.class);

			List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);
			System.out.println("Tray Types:" + trayTypeList.toString());
			mav.addObject("trayTypes", trayTypeList);
			mav.addObject("itemsList", itemSupList.getItemSupList());

		} catch (Exception e) {
			System.out.println("Exc In /itemSupList" + e.getMessage());
		}

		return mav;

	}

	// ------------------------------ADD ItemSup
	// Process------------------------------------
	@RequestMapping(value = "/addItemSupProcess", method = RequestMethod.POST)
	public String addItemSupProcess(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView model = new ModelAndView("items/itemSup");
		try {

			int id = 0;

			try {
				id = Integer.parseInt(request.getParameter("id"));

			} catch (Exception e) {
				id = 0;
				System.out.println("In Catch of Add ItemSup Process Exc:" + e.getMessage());

			}
			int itemId = Integer.parseInt(request.getParameter("sel_item_id"));

			String itemHsncd = request.getParameter("item_hsncd");

			int uomId = Integer.parseInt(request.getParameter("item_uom"));

			String uom = request.getParameter("uom");

			float actualWeight = Float.parseFloat(request.getParameter("actual_weight"));

			float baseWeight = Float.parseFloat(request.getParameter("base_weight"));

			float inputPerQty = Float.parseFloat(request.getParameter("input_per_qty"));
			int trayType = Integer.parseInt(request.getParameter("tray_type"));

			int noOfItemPerTray = Integer.parseInt(request.getParameter("no_of_item"));

			int isGateSale = Integer.parseInt(request.getParameter("is_gate_sale"));

			int isGateSaleDisc = Integer.parseInt(request.getParameter("is_gate_sale_disc"));

			int isAllowBday = Integer.parseInt(request.getParameter("is_allow_bday"));
			int cutSection = Integer.parseInt(request.getParameter("cut_section"));
			String shortName = request.getParameter("short_name");
			System.err.println("Short Name " + shortName);
			ItemSup itemSup = new ItemSup();
			itemSup.setId(id);
			itemSup.setItemId(itemId);
			itemSup.setUomId(uomId);
			itemSup.setItemUom(uom);
			itemSup.setItemHsncd(itemHsncd);
			itemSup.setIsGateSale(isGateSale);
			itemSup.setActualWeight(actualWeight);
			itemSup.setBaseWeight(baseWeight);
			itemSup.setInputPerQty(inputPerQty);
			itemSup.setIsGateSaleDisc(isGateSaleDisc);
			itemSup.setIsAllowBday(isAllowBday);
			itemSup.setNoOfItemPerTray(noOfItemPerTray);
			itemSup.setTrayType(trayType);
			itemSup.setDelStatus(0);
			itemSup.setIsTallySync(0);
			itemSup.setCutSection(cutSection);
			itemSup.setShortName(shortName);

			RestTemplate restTemplate = new RestTemplate();

			Info info = restTemplate.postForObject(Constants.url + "/saveItemSup", itemSup, Info.class);
			System.out.println("Response: " + info.toString());

			if (info.getError() == true) {

				System.out.println("Error:True" + info.toString());
				return "redirect:/showItemSupList";

			} else {
				return "redirect:/showItemSupList";
			}

		} catch (Exception e) {

			System.out.println("Exception In Add Item Sup Process:" + e.getMessage());

		}

		return "redirect:/showItemSupList";
	}

	// ----------------------------------------END---------------------------------------------------

	@RequestMapping(value = "/updateItemSup/{id}", method = RequestMethod.GET)
	public ModelAndView updateItemSup(@PathVariable("id") int id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("items/itemSup");

		RestTemplate restTemplate = new RestTemplate();

		try {
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("id", id);

			GetItemSup itemSupRes = restTemplate.postForObject(Constants.url + "/getItemSup", map, GetItemSup.class);
			System.out.println("itemSupRes" + itemSupRes.toString());
			List<RawMaterialUom> rawMaterialUomList = restTemplate.getForObject(Constants.url + "rawMaterial/getRmUom",
					List.class);
			mav.addObject("rmUomList", rawMaterialUomList);
			List<TrayType> trayTypeList = restTemplate.getForObject(Constants.url + "/getTrayTypes", List.class);

			mav.addObject("trayTypes", trayTypeList);
			mav.addObject("itemSupp", itemSupRes);
			mav.addObject("isEdit", 1);

		} catch (Exception e) {
			System.out.println("Exc In /updateItemSup" + e.getMessage());
		}

		return mav;

	}
	
	@RequestMapping(value = "/getItemCode", method = RequestMethod.GET)
	public @ResponseBody Info getItemCode(HttpServletRequest request, HttpServletResponse response) {
		String code="";
		RestTemplate restTemplate = new RestTemplate();
		Info info=new Info();
		try {
			int catId = Integer.parseInt(request.getParameter("item_grp1"));
			int subCatId = Integer.parseInt(request.getParameter("item_grp2"));
			
			MultiValueMap<String, Object> map = new LinkedMultiValueMap<String, Object>();
			map.add("catId", catId);
			map.add("subCatId", subCatId);

			 code = restTemplate.postForObject(Constants.url + "/getItemCode", map, String.class);
			System.err.println(code+"code");
			info.setMessage(code);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return info;
		}

}
