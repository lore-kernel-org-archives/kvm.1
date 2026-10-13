Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5AE539763;
	Tue, 13 Oct 2026 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917974; cv=fail; b=YTutw6e7RUBopCKEUWqoE6mhLDSmSyAvFKaf+Qpl+VUh7MR1B9YaZe2e7RaO6eylrK/cRLA4C1g6PTuyMKnjRpQauM6s15fr/wESGAIXqggKlsKjXhFi5F49pnYsLhMTH2y1dmWMVfKLod7Wu5kW6ml0zx3avGOEjYSDN0Ea0iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917974; c=relaxed/simple;
	bh=18jhlC8SL8h20at4kvg4FZlWwkGu4FImxgdVhh1F68o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mqGzA2MVQ+z16Yv+WoNgKaO8KXq3UuBoovn0b0aMMDiMFkTw1gh+dpMSFsSNCKMWSbGcOL5/jHqJ7Z+Y2S4QqJcoE7H8BmUDnYIUJbVWJyl0f1goVbijyBbpm6avmL4R9tEbyqYwiRNxCmFAboTq5ANEjBdH+09ZGxCqLSDoPAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktZAfPPU; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktZAfPPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791917973; x=1823453973;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=18jhlC8SL8h20at4kvg4FZlWwkGu4FImxgdVhh1F68o=;
  b=ktZAfPPUPx8kwuShAC0/CNz/1fXPCt/Y+Udpesd+idhYALC2WJZTz0Ow
   eVOcDz6jQ3SFhOeCfvAFi6w4skaCuhvQE+Q95q1nKW3kRt9GBn7tpVZOG
   4K5NF5VOKAbLHYwzONLjAD15tMKZ+O10GUwDSYW8ZrNKyJtgwt83nUO3+
   jTKLjYek+aVLgvfrZ2JwbC3tpeddVG1St2HgFSF3aS8RVJafNiY6IADcL
   CuMEfWd+n9yraODXPOKm5xY4jEhYeZIpsjfqCW2hefPLvwo1aPJTOeEja
   kqUdGwVnOOz6WAC1FMJ1AXVxj3nGBF9Bp/lA7cboX7cguqULJzEvemQfk
   w==;
X-CSE-ConnectionGUID: PKLKoFYxR42lNBvj8Ryn6Q==
X-CSE-MsgGUID: 47h2Y3m2QuuFqTru5k/iog==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="552892"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="552892"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:59:32 -0700
X-CSE-ConnectionGUID: HytUHirMRF+a+tpwF4kOXA==
X-CSE-MsgGUID: euiB33+9QQC/iheKGOR20A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1597960"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:59:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:59:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 11:59:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 11:59:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8JjqNFdub+GeXDIfZEp/CD5u6Ay/pH32qlSO2Jl3j3t51TQTqmG+PXkdYOjnXJu+U6dBSmRGjzawwy6FqeSZzDMWvx3fNOx4MlOX7luBBg74Zk57yPNDzuEPqAqPK8613VysSL3+GWDq3IpQZDn2dwKXsRtHqSAC+An/VbTwHi/aB8VH1jqjtMXq5FgLfYYSkAhd/GovbMWmKa8U59y1MtuWEgNBlP47FoNN3Z85aETarC8eXrcjfbpM2CLH/UscBSjTfVLFDwGcfugvHKFkPAWf7pP88Rh1YQYWjfAdBAGIBFrXdWVf+cV2NRB74YBMNetZct48LmlLF3e87LVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18jhlC8SL8h20at4kvg4FZlWwkGu4FImxgdVhh1F68o=;
 b=UxvCL9W3fAzkI5rgADp1drPd+wjx4eHTVEHky11MWj1tNO/9qVIQvmDvxsk9Vwv+v0Y5sn5Sh46A2GxUf9mPgjxP7s6cyr+jpbU5uC+dIn+QdFY4zpznFmQD8unh1E9pKcM1D9WCJK1h6GTku1zvi4WflS7X5JhT0Zeso523hkwZrDdHa9ZYkWwtfyXkt/bh3FujCh6FzUIBo5QcVIkPFKt9SkZMaaUIb3Vlr6jvnF2MyonP1tQM59gPDXWZM+E8utBHi0xluBMLStLCF5XlKt4+IMZhAS/ctm6DH6soj3VZBn3zj0ziNqJtoXixL2e6TiixFVWgbozGOw6zF8IljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MW4PR11MB6811.namprd11.prod.outlook.com (2603:10b6:303:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:59:27 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:59:25 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Xu,
 Yilun" <yilun.xu@intel.com>, "artem.bityutskiy@linux.intel.com"
	<artem.bityutskiy@linux.intel.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>, "Maloor, Kishen"
	<kishen.maloor@intel.com>
Subject: Re: [PATCH v4 4/6] x86/virt/tdx: Support DPAMT when adding memory for
 the extensions
Thread-Topic: [PATCH v4 4/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Thread-Index: AQHdWyhVANI+7ssvs0OgzOqTVvuc7bb705qA
Date: Tue, 13 Oct 2026 18:59:24 +0000
Message-ID: <462fc642ef687ed8574ca43cc3b252d0cd667112.camel@intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
	 <20261013-tdx-module-ext-v4-4-de5ffac65470@linux.intel.com>
In-Reply-To: <20261013-tdx-module-ext-v4-4-de5ffac65470@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MW4PR11MB6811:EE_
x-ms-office365-filtering-correlation-id: beb1aaf8-c3f2-4f35-c7bc-08df295c1963
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: Pd5wjN4NrBORvv+anT9bFqKBkwBe5/T4HNt/zyokPrfsXeRch3/iz0C1CjSN3l9E2xYNGdG+YQT7qw9Pn5yGI2PDPEOiOkDlpSFrVGrMCs1aW1aPJtgcA/L5dmVaWNbjDTLSCUfbWzN84D6dWyK+F62HIiXwp0B1oNcRd+7K8FyCCjItHeBGMwBSgln/PLx6bnkxKwNdssMye/vfMgFqSqQXp9XhldWT2ifU/okyHe3PpEEA1ukF9KE18z66bRYcVYimJyK/Sj1rCtoqpKa58gpEFz1x1hiBvpTm12yURbJbY93NENc4zLTlgf9qoeocYrWM6LweRbZjVAK40it7iQ5LA+O08BGo0ERJk0z2rICpC3G1Trjb6Mk2THPZKs6pl2PUEl9MAUNX3MvWqlD4l3T/WN+3nOM948WZBBLxguUv//wCu65cSTli4cpps5SHJGNCLCLUsZdMMw3yCO0u2T+8esn+WkM9TQnWhQbpk0LIiCuO74aaXlLJzU8w+azPiVC3Bgq8IyYPgsSJOfoR8dHdSvYnd0uVX9wRwA2/mKIXSv8FPMydfn+TKGoGEtij+J8rNIYWHzOthwPTGf7kT/nEC9LHyKbSf+/7+mxLSZjbdIpyU0OWxSp4bnZHJU6Dgy5fc/F+xOjLzXLqSoK1ImIcCzbaQQXkjpYTSDDoaPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2prZVJUQ0tlbTVZdUNpTTB1UGVqcUpJbGRhWGt6a3ZxSU1JblZMZCswNEFP?=
 =?utf-8?B?a2ZvWVdaVU93RVRUQlgyUjhPWDRBYWtMVm5xS2tCU0dMbTd2RDFVZTcvVEhL?=
 =?utf-8?B?TlcySUpmVmRoTWZ2Skw4RVlqMmtpZkZVOUI0WlI0ZSt6RkFINWZRQTZ2Vmxu?=
 =?utf-8?B?Z1BNSXJDdE1Vb3cvZ0N3SUFVMVVwZGFYSG5RWDNlcTdERXpQNmx2NkZoaVBX?=
 =?utf-8?B?VWlNTUJRLzFxanU1MEZzTFJ0ak9vczNYdWd4TXR1UDFlWi9SemFJaXlkRG11?=
 =?utf-8?B?SzNSY05uK1JPMExDbVdjV20reFZ5OHlUVmRPc3NseHpuZ29jblhSbWtIQkxk?=
 =?utf-8?B?TVFjWUpLaHlvcVkyRm44OHcvSlhJaWI4S0FQNHY4RnB0U2crUm01U0liME1O?=
 =?utf-8?B?dnFTQU9pT1E0U0s0N0s4a1lDRmJTZ2drdXJxbU9TdkJVTGlKTmRPanJJSm5G?=
 =?utf-8?B?ejlIeTRHak5pQ1c3bXVwWHNJK1pUQXZvcW5pK3pXQS9vbWpWVkFkNUpTdnFZ?=
 =?utf-8?B?ZEduY05yVlpUWDhYeGFyc29Ga2FXZy9USmVSNnNkeWJLMzZRZDVxc2VSWVdH?=
 =?utf-8?B?ejJDSzdVVzBzKy9iQVE5alJPbGthS2RGL1RGYVdKN1ppbzN2RUdrTlA3N1Ex?=
 =?utf-8?B?dEZIcFVRb3JJVXRQbnBiUDREd0Q0RVJKWVNtTWg2cjVNMUZCTVg5Y014LzI3?=
 =?utf-8?B?aVlFeWM4NlVJU0dTVWh3OFpRMXlyaDVDM1ZWS2ZhMlZ2YWZMaHN4ckRpclFv?=
 =?utf-8?B?YkdqQTd1VVc1ZjVOaVdKN211bW9XRnBMcFJPVVJyOUxwZnZmQ3RDODdDR3or?=
 =?utf-8?B?c0JxNGpoTG0vWjNmZ0NkOVJNeC92S1l0Rmd0dUZDUE0zL0NOejAwZzZPMU5E?=
 =?utf-8?B?T2ZJd1BLZEx3MzhSRk91MWpWYU5rYzFFWW1GWXo2Vm1zSmZZOGNnNU1PcWtB?=
 =?utf-8?B?d0F0S2pmaGRQUjl2bG8rVWY0TE94d01HWGpLaFF5VmZoUFZ4OXFjamZJVWJs?=
 =?utf-8?B?RlF6Yzc2bUFibjV4WGV6Vk9Bb2sybXhQUms1UEIrQXdBVWlvNWdsYnoxMTE3?=
 =?utf-8?B?ZGoxYW1kUW9uOVIrYVg3YXBaMjNpK3NaT0I1Rmd1d2ZDYlE2WTFMSzBCcndY?=
 =?utf-8?B?YXk1Mk80bkNkOTBCZlkxS3FibE5kUnlFc1didjVDZ3FmM1JUc2UrTE0vVlpn?=
 =?utf-8?B?bmsrSVA2MGxFT2tUR3BRcjh2VHJPVnc2V2ZpL09ub2lCNjF6TkRic2ljNGEw?=
 =?utf-8?B?eHQ4ZFlFRFJ2VHc3U04wMi9OSXcyNW1jSUlWcVVFMGRUNUlyVlJzanFoVXZO?=
 =?utf-8?B?NmZDcWdhSVFkQ3pqdUthNHovZzlkenJMWXlSVHYzVmdRV3JIcHlDUXlJM2cz?=
 =?utf-8?B?ekwwRmJrSnZnZ0FBL2hFS01JY0xLOHFwNk1lZEpsSExqcUhNN2FpTHJLY2dy?=
 =?utf-8?B?Wm5zbTFaNXBxUG5WS0QxWC9HRzBHbXIrckx2TXdRV2hmVFRCRDI2Z0MzWTIw?=
 =?utf-8?B?dU5iU1dIRTc2VEtMNnNzd09XazJ0TWRqcWJKZERpRjBpY1g4dGRGODBDY0Nl?=
 =?utf-8?B?UVNkWEJuT29QUVpzaWtNQ2R3MWptM0VTdVN4V0h0c2ZXcWRXeGhFZ2NKYnZX?=
 =?utf-8?B?cXNOZEJ4NDRxM1M0VG9QbEUzWXdyeEwvK2UvTmt4Ky96cjcyVXIza0ZMb0J6?=
 =?utf-8?B?OTBmRGpUanRTTDVneWNka2NITVBNS3pqNy9VZTNYbVZ2VlVrRWY0Z21Oc2kw?=
 =?utf-8?B?ZHhsRFplQXhLeGhNeUlSR0g1TkhVa3VCZmlEMmI4MTE5L3o4UktwRDdJbkYx?=
 =?utf-8?B?Y210V2l5b1dlblVhRk54K2lFcTBvWU5yZnlRc3lEaUxjTTNTVjhzSjJOVS9w?=
 =?utf-8?B?NFUrcDg2V1hqdWcvVWFPS3lLUldrZzBQVzlReXNnUkNRSW5oREdObTdFZU5S?=
 =?utf-8?B?L2JkUEtPZTVnVEtCcW84T0o2S3ZiUVRBWGFmalVVdllmQVZJS0lXbEI2Q1M1?=
 =?utf-8?B?QVZ6Vi9DSEpLdlhaRGFNQnUzMzl5QmRVRHdxaEdxaHhHd0pMakF5dk92aDdH?=
 =?utf-8?B?QnhLRkJMeVhZSk9IOG8xOGlRUFFMV3I2UWxrcnhLb0VUVHlpUm4xMGNaclJE?=
 =?utf-8?B?eVFFRnFKR1NhbU0zYWt3UmVyU3ZnVVRtNVhxRU9uKzl0aC9Kb0ZxbXZOZlVT?=
 =?utf-8?B?UTZsSGRJU3JtZ1JsN1YyMEhsR2NiVUl5cFgrRHRQWStQYkdjR0pueE5EamtK?=
 =?utf-8?B?M1VsMVEvMDhtWlhLc25JdldiZTFTK2hRcU1NMGVZSitVeitFTnAxellJTWVo?=
 =?utf-8?B?dlZsTUx0bVF4MDk0b1pEa0grY01IY0xWWS9zSVUrdmdKZXFCM0hzVkdoR0dl?=
 =?utf-8?Q?5QYGtlpiNy/Lc1gY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F86A6A891054134AAE5E37987410EFC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l8V8q2y7rnHUbAcUfqpCuMlvggueEQAvCo5Qh+BB57qou775TDy6LprYnJNo0pEzToeF93PjDkhCnlczDjEAdrLyYTFeDOs4j+CeXfe3VS87dwd7SBumpOsvGa7hHsJGPBFzTigVKY6l4CYIoC4DFsUXlYOw6aVJ1CmpsdkR6DPyWMdC6PcaTP50hoe/XioM68d2xzKJ9mCP0sTk7vBAni/sJCMD6rDc74h3iudlkQSrT8sLoEY7s59XtyNGlIkwBKd+JHyKWiSEZfRh2tFPno+uWSQhfK31GFqRr7h+RYZqKuBisBBvZgatwrMYE0IZYNi2ysfdTEYZaBly061VsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb1aaf8-c3f2-4f35-c7bc-08df295c1963
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 18:59:24.9414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POOLBC5UCeZXwRPLhTfIFWa8nuCPRtriNq//FECMKKNtCsh0tp5gpun6WfdZnqSsuVq8DUgrvw8I7cuIxV+WgwZ0lmEhfgtgETsD/STsKu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTEwLTEzIGF0IDIzOjI4ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gVGhl
IFREWCBtb2R1bGUgdXNlcyBQaHlzaWNhbCBBZGRyZXNzIE1ldGFkYXRhIFRhYmxlIChQQU1UKSB0
byB0cmFjayBzb21lDQo+IHN0YXRlIGZvciBlYWNoIHBhZ2Ugb2YgcGh5c2ljYWwgbWVtb3J5IHRo
YXQgaXQgbWlnaHQgdXNlLiAzIGxldmVscyBvZg0KPiBQQU1UcyBhcmUgdXNlZCB0byB0cmFjayBw
YWdlcyBvZiBkaWZmZXJlbnQgc2l6ZXMgLSAxR0IsIDJNQiBhbmQgNEtCLg0KPiBUaGUgRHluYW1p
YyBQQU1UIChEUEFNVCkgZmVhdHVyZSBhbGxvd3Mgc2F2aW5nIG1lbW9yeSBieSBhbGxvY2F0aW5n
DQo+IDRLQi1sZXZlbCBQQU1UIGR5bmFtaWNhbGx5LCB3aGlsZSB0aGUgMUdCIGFuZCAyTUIgbGV2
ZWxzIHJlbWFpbg0KPiBhbGxvY2F0ZWQgb24gVERYIG1vZHVsZSBpbml0aWFsaXphdGlvbi4NCj4g
DQo+IEEgcHJldmlvdXMga2VybmVsIGNoYW5nZSBbMV0gZW5hYmxlZCB0aGUgRFBBTVQgZmVhdHVy
ZSBieSBkZWZhdWx0IHNvDQo+IHRoYXQgdGhlIGtlcm5lbCBtdXN0IGluc3RhbGwgRFBBTVQgYmVm
b3JlIGFkZGluZyBhbnkgNEtCIHBhZ2VzIHRvIHRoZQ0KPiBURFggbW9kdWxlLg0KPiANCj4gQWx0
aG91Z2ggdGhlIG1lbW9yeSBmb3IgdGhlIGV4dGVuc2lvbnMgaXMgdGVucyBvZiBtZWdhYnl0ZXMg
YW5kIHRoZQ0KPiBrZXJuZWwgYWxsb2NhdGVzIGl0IGluIGEgbGFyZ2UgY2h1bmssIHRoZSBURFgg
bW9kdWxlIGFjY2VwdHMgaXQgYXQgNEsNCj4gZ3JhbnVsYXJpdHkuIFRodXMgdGhlIGtlcm5lbCBo
YXMgdG8gaW5zdGFsbCBEUEFNVCBmb3IgZWFjaCBwYWdlIG9mIGl0LA0KPiBvdGhlcndpc2UgVERI
LkVYVC5NRU0uQUREIHdvdWxkIGZhaWwgdG8gZXhlY3V0ZS4NCj4gDQo+IFRoZSBrZXJuZWwgaGFz
IGhlbHBlcnMgdG8gaW5zdGFsbCBEUEFNVCBmb3IgYSA0SyBwYWdlLiBDYWxsDQo+IHRkeF9wYW10
X2dldCgpIGZvciBlYWNoIGV4dGVuc2lvbiBwYWdlIGJlZm9yZSBhZGRpbmcgaXQgdG8gdGhlIFRE
WA0KPiBtb2R1bGUuIE5vcm1hbGx5LCB0aGVzZSBvcGVyYXRpb25zIHNob3VsZCBub3QgZmFpbCwg
YW5kIGlmIHRoZXkgZG8sDQo+IGludGVudGlvbmFsbHkga2VlcCB0aGUgZXJyb3IgaGFuZGxpbmcg
YXMgc2ltcGxlIGFzIGJlZm9yZSAtIGxlYWsgYWxsDQo+IHBhZ2VzLCBpbmNsdWRpbmcgdGhlIGlu
c3RhbGxlZCBEUEFNVC4NCj4gDQo+IEFJIHdhcyB1c2VkIHVuZGVyIHN1cGVydmlzaW9uIHRvIHJl
dmlldyBjb2RlIGFuZCB3b3Jrc2hvcCBsb2dzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWHUgWWls
dW4gPHlpbHVuLnh1QGxpbnV4LmludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtpcnlsIFNodXRz
ZW1hdSAoTWV0YSkgPGthc0BrZXJuZWwub3JnPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyNjA5MDQyMTU4NDEuMzAzMDcwLTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20vICMgWzFdDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21i
ZUBpbnRlbC5jb20+DQo=
