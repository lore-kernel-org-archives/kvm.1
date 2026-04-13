Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E35391859;
	Mon, 13 Apr 2026 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776107322; cv=fail; b=ZyTBooekNvOzEvH7LGanhVHfwJRT2zdD/lZgfjADAuKxZTYha2F6U/U2PVSSosZ09GJth/0LmvU4GNT9FldeT0GZL7SFiVXd+n34nd7QVNp3JSHSQNSnmtUVYa6yTzQHyQk/tBwFpChkMwM0qtczDN0Q1K9m5QiJ36R6OXQ+r0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776107322; c=relaxed/simple;
	bh=K4y8frY2b2vguTBr+SvDvMZmwg+IqMYfYn2u+ixqAp0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LARdLn7PTcv7e/hyBzSDewurmwJhZX6HUdT+lTxI9kHRS7X5nzSH31CS8JF8sZY9AZodEs5eyRuPtzdmOshwEKn+A9WIJGqxpyUOh9nXO2FpNKdbc408ZxmF8SkCHson15dBpOyB840PbXGihUTpsfZE/WeeUvSP6MS4Zpbjdbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XFWxbsJc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XFWxbsJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776107320; x=1807643320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K4y8frY2b2vguTBr+SvDvMZmwg+IqMYfYn2u+ixqAp0=;
  b=XFWxbsJcOyajXsENuJ2FwL+XQ/iqfrai+YYz2CBDFf39WWAMWElkQ5tY
   5QIniQepY3565L/ltmmk1964E3WvYQHV1GDNRUejplxSUGMXU3j3qdlkJ
   iiyuDpgzAz4jjeE1YmEU8Gf3mredu7fu8tayAL3euZJcZpSzKVU5Mrso8
   Vx7A4mmoSjZw6XKWwVrZUMTaknUkKANzZPb9h0VnL9q/kgqO3IpYrDh9W
   RqgjhIF3F4SWdx69qeXowUePyRuXKj0M7Vyorjf/lVFlhQyEFUTXKik1L
   lhekdLPafgwHrY9YQ7xvfumnHDY7CGWTo056oPdM0EQYnI+laB/uH1pyS
   w==;
X-CSE-ConnectionGUID: YXvy9nyGQiSKUQmtyQrRuQ==
X-CSE-MsgGUID: JBPgLO41RXSwk25XtyfnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76761628"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76761628"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:08:40 -0700
X-CSE-ConnectionGUID: esr0OGhAR/ySKs76FG2T3Q==
X-CSE-MsgGUID: 3BwXPFGbRrWUAV7MZqZgoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="267858743"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 12:08:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:08:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 12:08:38 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 12:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZFV4Fv9Q00ry6ElWGpWTGDdl3Xz5ulYBsKIEGqKZuU6mwXBfpYa8eWhFLXTxqhzxJWJo8Iu8Kv5UsFA+UUlTrfHYRcisGJDXpZm7Qc3jrkLPmXJdGLIJa1fopwfrxBkXR3r3fMnUYSSWvunbQamlGMT+p9fi9d2unF299oroY8BrMslwGtpTW5XIGYvaw+ttE5RgAAbs7v8OIwNeM0pkabZhIPutZiTRnu3nSiDPe3EJ55XGcPuNI7mvhRCuOFcgCzhB5nfousHpstvoSkOi4AJ1HdBq9Fn1u+popgsF+OAZQh7dgY9r7Rdr0HzYt5R/w2X6ttVh8Elorf/RtiLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4y8frY2b2vguTBr+SvDvMZmwg+IqMYfYn2u+ixqAp0=;
 b=azxkL0bQz1z2POT2kHxYByk1RuSMu+9Mg9bW1R4Zkxb2TBwr4kZsIrM1gPRWUtsOK77sdPFuSyDoKSFhyoc9WSezsziNAUsNU1/FGWuekkYP8HVx9Q0TWz0e5fawJ5seIB4jpL00cWcjXSUlpdyvB/9ziK4b4dkdOrnLaDIG9VMil+854v++QPzh7tWlJz+Pm25HxNgymtHz5rfpebXprKydLCytnDT4Kg+nDW4utP8eq0rsvjH27xE4tt4h29S/siwpoF8Ivx/sRSyvpwv+O01LV3dL3fGvGAFFKCQHlOzf4qxsbMmgzNzFxqedtVOSO2tzrwSvAlJlPa+8e+xL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 19:08:34 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 19:08:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>
CC: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Thread-Topic: [PATCH v7 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Thread-Index: AQHcwQv8Y8HdIlbNRUuaJqZi32fcQ7Xdb72A
Date: Mon, 13 Apr 2026 19:08:33 +0000
Message-ID: <fbcce1bd98ff8a7ff106f7583e3b576b170358cf.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-7-chao.gao@intel.com>
In-Reply-To: <20260331124214.117808-7-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW3PR11MB4651:EE_
x-ms-office365-filtering-correlation-id: bcdb718c-b45a-4e64-9480-08de99900e93
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: Iii2woTNgOGl0tGyWbeQq3VbXZzFro03tomgrqm2EcZOhkilTOyjt8tnOlFgKZJgNQ52IAOj0e9Vpq7tuC7KowZF1DkGUWz80nvcJXf2gX3V8FAHcIuvNDCT3I8FT/vy0rfszRwdT+4H766PhZR4/UD3Gbi/Wty2unIUVLMFRa1RN47ZvWjGibcMTeO957R/a6nfLruRD5j3GeqGqqMTLuuGSzyTSoadV2JnUZW9MZNb/MyrDbZMVuLFIR2Oe5BS7XeMMg41qnGpfe53/+VkWttJPmnolk/5tAXEivBqNsqWU65ufiCQo1anICVQyy8XPiofPe/ljOcervfItakhLxku3rse2fPIXkIqcSGnhQpkMezkrqo55auKZP7dpwwHMui4RMq1+8+g7RxwEvYAoW/Fc1ga+CjqQ8NiuH81ewPOtmI3qsHy9ECmii+xSjM/NQrv81Iu/XolqKOR+BDia3OU89kaoYsHDHPeWH1zroGbcg/cFbbg5MZYhJxGsRPgsLyfrbqNKOv4vukWejSKuaHAFh/2GQHv09RrWRUZQ4qy8qbkSN43H26G6JcCtWqFMmOz7mruCtq9BhKw3yrwTcEto76FuRK0qgCNDguTsCDbcRz1wnZFFHeH1Yqp2tFbcdp2zVr7dW+8Wj6696XzASwd+VJfICTZVSfB6/mn7CmTSZkRmYwt56EWCwnOU4aAGvVgqR+Hl+zrruTZuCrvBCXl5JdFk0x37vUSgPrPy619p/HH/j9bxYTqYVMhalOZmQCkDNM8eCvxp+p5aCUreXyqD+OmGnl4JxBlXZsYYAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b01uT0ovS2xMVW5lT3pCQXpkQmZEOE9LUXh5R0h3ajBXSllsOU54QlRzL3Q3?=
 =?utf-8?B?TGZzMUNmUUNBSVFuRklKcnpoUXBrb0s3c0JEZGRBQ2g4WTN6bkZsSDVsOTFH?=
 =?utf-8?B?VitXWmw5dlpHWDVqWkFpaHRraUxaQXlyTVJjVUtjc3lBWG93T3h0YVJIVS9y?=
 =?utf-8?B?S1pFOStleUthUFR6eHB1UVM2RHV6MXFkK0pTQTU2UVl1L0w4b2c3Wk40aWtk?=
 =?utf-8?B?emVMZURXT2l1bVEzTU9scXozNWwycFJPMlBzbG1QbGF6RDA0ekFiZ3NkM2ha?=
 =?utf-8?B?dTRxcFFaUC9VQzhiR1ZXK1VwSGQ2RUM5VVpzazBRVnZuMW5JdUQ0UE1WK3c4?=
 =?utf-8?B?QkZnK1lsdGR2L2k2VWNuNWpKcUpBdzhpTWtYSGRXVTd6ajhFZmM0Y1dNdUtC?=
 =?utf-8?B?dE1yeTZMR0owUTRiNkNJQWxnK1dQVmR2aWxNM1VWVjh0U2s5UDNWUzFydHc3?=
 =?utf-8?B?NEZXbjE3MzJlTHVnYjJ2N2tjczN5WG5YUUZLNWRjT3ZOK0NuZkdha2Y0blhn?=
 =?utf-8?B?VGZIWGJsVS9jUTAzR2xhNTRZR3k0czFTVmVrTmo5TmcxVHFIeGNkcnAxYjhp?=
 =?utf-8?B?cVR6c2VkdUZJWFZVUWl0L0VuOEo1d3UwQ3E4MW1NMzhBY2hTQTFnNXhwdWNK?=
 =?utf-8?B?Y2ZkOWwyOGhFM3dMWFlLNnluMnZYWEdUdlh2QVBqWTVzTjdhemNBVTZhK3RX?=
 =?utf-8?B?WFA0eU9lNDBFZ3NSN2tFSjkyM0VIY0tDOXF4QjFHbEtacUpmMGFiSXhXY2tB?=
 =?utf-8?B?ajdKWEErUU9WaEpCaFZmK1NQL2JKeG5PdzV3dElsekNqL29BNFJkNjVldkpX?=
 =?utf-8?B?L1FPalhxK0VUVkwySlVYeGlEa3ZPZy9aUlV3WmltVzRaZ0Q0Ti9ZYlJRV1dX?=
 =?utf-8?B?RGROZXZ6ZFVJbWNpY0phbVliejJ1WWozdE5lQmxEdm9weVViNVdFRHBJYzlD?=
 =?utf-8?B?Tzd6a3FWU0pjeG54cmlVMlR5VFZNVnNvMTV1ZndXQnEwYUpxM3I4L3NybENy?=
 =?utf-8?B?b1VzMFJ4eVE2dDRJSEZyeTI4U3FPNTdGUFd1a3NTcjluK2VXa0t5cVoxMHM2?=
 =?utf-8?B?VDVMOGFpLzFlQVBrRERGYk90d3hIWmNEUTRNVXpid2RTUTFVa09IUHRNdzMz?=
 =?utf-8?B?cG1Mb25EQkR6OHU1Uyt2ZVh6UUFDUzdhTk9wVlF6Q21UVjIwbkRxSjM0OVVh?=
 =?utf-8?B?WGNSY1picFZmazZrbkNhSjI2dnpzQ1NwOVFUYnN5cHV2YXpZV0JOMUNGR3ps?=
 =?utf-8?B?bmdib3FsSDFXMFNkWWZiL25LeWd1b0svL1JvcVZ2djdkWi9yQmZpY3JqNDQw?=
 =?utf-8?B?amlZL3dyRm1OQ1UyQW8yVXdmMG90UEpKeXNFRXZqc3JIemNOcHRGQ3pjRVpE?=
 =?utf-8?B?VFFBZFNyVGpocHlRQXNUUGpiUjNvVWlySHJaT003RmlOblFjVmpYbnVTQUU5?=
 =?utf-8?B?NDdmbVJYUVl5a1kwWnFXZENJUjB3bU1keGE0bkQ4bmhpUUdOMTBDNUxqY0JF?=
 =?utf-8?B?amNWeEpwRGQ3VlFFM3dDZXBXT2JyaFVZRHB0TUUwblVzbHpHb05xakdMN1VS?=
 =?utf-8?B?cGtOVVZETTMydldWRE5VbzlaVFhVNHZLR1NSejJxckR5L2FWaXhPTGhaNVhX?=
 =?utf-8?B?RXl4WnNoQ2NXSWpCSlRyVXdTaldkak03bzF5WGlhTWh1QlJXeGwxWC9uU1VD?=
 =?utf-8?B?R2FzQThsQ0VYYmFyM3I2cTg1ZDJWelk4SElMYVJaKzVXc1JiTjFOT3NmUk9P?=
 =?utf-8?B?WE9NZ3F0ZWRQYlBSNUlhMFU4bkZZK3N6RmY5NExMS1lWN21Sd0FaQXNIZ0E3?=
 =?utf-8?B?V1hwNFdQZUVUM3ZMNjlVZkdHVldVQUp2TkhsT1VZeVYvaldZd0h0RVhtc2sx?=
 =?utf-8?B?ZUtJeWM3K3NhcTVqL2wyTytURkRxTGYzdy9sd2lHTExHVTNxb0lNTjFWb1pJ?=
 =?utf-8?B?VlY1dWN3OTNkTTdDZm1wMldGNDBpQ28rbUxFdTZmR3gzZVY0WitMR2ZDS1Ru?=
 =?utf-8?B?K0RoZTMrZmZqNklTM0s5ZjF5akRLUHRsQWl5U2pValgwSnExNlI0dVZRRVo1?=
 =?utf-8?B?Y2t6cHB5S3FPVVp2ZTdMNC9kVVdnSXpkZWZnNGVhelVyOVpvclZwQ1ZJUVQz?=
 =?utf-8?B?c3AwUFd4REZKeGZqc2lONkRaYk50QmczN0QrdDJ4Z3JHSCsrTFhpY3p5ZW5C?=
 =?utf-8?B?UnZoUm5Ga3RzVlgxZ3Vyck9jNmdXZjhsVjBRYVRqVUYycUJzckpMSFFzOUVx?=
 =?utf-8?B?aXh0UFNDOHVWZEMzUU1JL3krVzVXUjJ0cVVENFp4TTRRcXNjK3Z3bG9ZbllP?=
 =?utf-8?B?NmFtSVY3T093eGwzMktXZkdwUGdaRFpESU9kQy9ibTlCZjJzUStGSTdMZng5?=
 =?utf-8?Q?Wmfh4+xELuPqN1aw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C11D516E2F982845A17B6C5359C1B376@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NdPhFbFr2e2rTs3jTv+hEIbt97BpPQwJ9GZy6c2Pjw6NhrdEJ4pGYaapu/wrVs1h0KMnpAJUaT5OSrbmRBQLokOU6j+okZJWMZJPS4CY9XAWrmkZ6Qd0RqOgtUPoCL8Y/dM9OkpAfCRQbIqsNcg+/CDnBE/uBpaY2MkXNQDAoBRPaCDdBWcflZ25XGPvIYh/YJMlLpsP/rCLBeAu/xKrcWufngU+ESeBpB89STAzR1akRcTPMiWUBHoaVWxXoi43U3Ap79whMAEDvQW5XHTWzs2CjCPNfkA7chVBg1N2U6+TfQqxIV8Ahwv3U4DCIEEHxlBdOWz5sc3JZuQeLOvMWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdb718c-b45a-4e64-9480-08de99900e93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:08:33.1918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icqP+Nd2N7b2w8Joijic185kMo96Kwidd6V8rFIpGgs9gJw1iEygrALkmO0AryQdRVcaJHBKD2IbIJ0LTr7rHw7ZkSe/19A8WfWfZ+NQMe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4651
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDA1OjQxIC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVERY
IG1vZHVsZSB1cGRhdGVzIHJlcXVpcmUgdXNlcnNwYWNlIHRvIHNlbGVjdCB0aGUgYXBwcm9wcmlh
dGUgbW9kdWxlDQo+IHRvIGxvYWQuIEV4cG9zZSBuZWNlc3NhcnkgaW5mb3JtYXRpb24gdG8gZmFj
aWxpdGF0ZSB0aGlzIGRlY2lzaW9uLiBUd28NCj4gdmFsdWVzIGFyZSBuZWVkZWQ6DQo+IA0KPiAt
IFAtU0VBTUxEUiB2ZXJzaW9uOiBmb3IgY29tcGF0aWJpbGl0eSBjaGVja3MgYmV0d2VlbiBURFgg
bW9kdWxlIGFuZA0KPiAJCcKgwqDCoMKgIFAtU0VBTUxEUg0KPiAtIG51bV9yZW1haW5pbmdfdXBk
YXRlczogaW5kaWNhdGVzIGhvdyBtYW55IHVwZGF0ZXMgY2FuIGJlIHBlcmZvcm1lZA0KDQpDYW4g
eW91IGV4cGxhaW4gaG93IGFsbCBvZiB0aGVzZSBvdmVybGFwPw0KIC0gVERYIG1vZHVsZSBzdXBw
b3J0cyBtb2R1bGUgdXBkYXRlDQogLSBTRUFNTERSIHN1cHBvcnRzIE5VTV9SRU1BSU5JTkdfVVBE
QVRFUyBpbmZvDQogLSBTRUFNTERSIHN1cHBvcnRzIFZFUlNJT04gaW5mbw0KDQpJZiB0aGUgVERY
IG1vZHVsZSBzdXBwb3J0cyBtb2R1bGUgdXBkYXRlLCBkbyB3ZSBrbm93IHRoZSBTRUFNTERSIHN1
cHBvcnRzIHRoaXMNCm90aGVyIHN0dWZmIHNvbWVob3c/IEl0IG1pZ2h0IGJlIHdvcnRoIGEgY29t
bWVudCB0aGUgcmVhc29uaW5nLg0KDQo+IA0KPiBFeHBvc2UgdGhlbSBhcyB0ZHgtaG9zdCBkZXZp
Y2UgYXR0cmlidXRlcy4gTWFrZSBzZWFtbGRyIGF0dHJpYnV0ZXMNCj4gdmlzaWJsZSBvbmx5IHdo
ZW4gdGhlIHVwZGF0ZSBmZWF0dXJlIGlzIHN1cHBvcnRlZCwgYXMgdGhhdCdzIHRoZWlyIHNvbGUN
Cj4gcHVycG9zZS4NCj4gDQo+IFVuY29uZGl0aW9uYWwgZXhwb3N1cmUgaXMgYWxzbyBwcm9ibGVt
YXRpYyBiZWNhdXNlIHJlYWRpbmcgdGhlbQ0KPiB0cmlnZ2VycyBQLVNFQU1MRFIgY2FsbHMgdGhh
dCBicmVhayBLVk0gb24gQ1BVcyB3aXRoIGEgc3BlY2lmaWMgZXJyYXR1bQ0KPiAodG8gYmUgZW51
bWVyYXRlZCBhbmQgaGFuZGxlZCBpbiBhIGxhdGVyIHBhdGNoKS4NCg0KU2luY2UgdGhpcyBpcyBs
YXRlciBoYW5kbGVkIHdpdGggdGhlIGVycmF0YSBjaGVjaywgd2hhdCBpcyB0aGUgcG9pbnQgYmVp
bmcgbWFkZQ0KaGVyZT8NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBHYW8gPGNoYW8uZ2Fv
QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtpcnlsIFNodXRzZW1hdSAoTWV0YSkgPGthc0Br
ZXJuZWwub3JnPg0KDQoNCg==
