Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E18781724;
	Mon, 18 May 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103877; cv=fail; b=o9EBuDACie7/nWsrfiXLrZW83+ZJPeErnbftD0N6bQ9TpumAIN1Q0UDh4RGewL4AczZadCnINDMDSXdfoTkPidG2nC/ZFBDClkSCvVTKQcTxf3BQVZNbHYZkLgfYefSAXEpBzXR9B/jV0SLhhMzxiCJuekiyXzefoXbAY5SQzkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103877; c=relaxed/simple;
	bh=BYPGu/AWLiNY9j4xB/0VJclixWRmVbj9qYpcCrjQph8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdHGb80FAs5Idp7QDht5NlvfyzPArf8yzPoYtoxuVL1itTcik+ZDVs52e1BN5vgCr7vXKXWHdU05Qfhw5xHjoNXQ/6xG21Vw5eW9/Evuzc1K9dk28U+3OPklrztOs4oLJCJychbhtLjnWt4SJw/p1pgWWahX8sNHSbMz70p3aPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjDA4BDm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjDA4BDm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779103873; x=1810639873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BYPGu/AWLiNY9j4xB/0VJclixWRmVbj9qYpcCrjQph8=;
  b=JjDA4BDmERfXFYe3iBn+fz+DYTMxRt5p0x67ZUeI8WkUdKoDQxyEIJGv
   4Ho9dTSf+JNV6C2Fxw479wDVld0EFQwCf3HdiptTeiQlsK/Pi4zbGSK31
   eq4QgSSS2z2okDmjYP+r/45BpkMaK1VOnS0UCchfFv0Seib2toFdXlhaX
   n5+Gomwmf8huwvxxE1VciRJAr9wdtSkAMo1fai8ZxVwruHPCeM6+Wqg2A
   zKegOSiSzlA41E5OAgvw8AQow1q+Hf+xzkQGo5rTx1+xoy1SIKW3a3gi8
   upCr7Jtm0PqioJylgiGEH1PThi83Pkqxpbno7sl+63WwXzl65Tp4TcRGC
   g==;
X-CSE-ConnectionGUID: 1rqmbh9TQP2hYnHao0cQNg==
X-CSE-MsgGUID: PkuS37SlTZ6QBKT/upAgcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="80074381"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="80074381"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:31:11 -0700
X-CSE-ConnectionGUID: zPa6QDv6SsWvIISujPsPqA==
X-CSE-MsgGUID: t2wXJpPlSgqTFVtSou1K3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="235162038"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 04:31:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:31:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 04:31:10 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.24) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 04:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkJJ0h5UYeanYSbvJ38yCdyrGnDg5JfPOq/o9V7oS3aI7pLJl8ce/Z/BmkcZUpHKHEJ4R3R3UVVNYCIyyl+PhgnxKABlO8BU1ncpyz3EKaujG9yRAuKbBT9/UwMqE1UIOS9xdR6J1p5aRQUBAKSHUB2OSmv548obQ5HXcatsuqsvIPRYlU/C1BBpt/wVi2nrdyzZRwHsAAIZBjTTvPc3JvUCsxMTfMLO1+2EHG/jVkgO/efSch5CgpcVOuFFv88fy1oGaw0P7d/leGiCTL0uIfkIRbEEli/zII278bGyMGIgZ4w1hMBJmlaRZR7zanJNvVzQdy1HjzJy/ad08xfxQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYPGu/AWLiNY9j4xB/0VJclixWRmVbj9qYpcCrjQph8=;
 b=V8Kvey/o9QRnMo5zNZDjiD9EH4AyBWTYdC4v4GEY5Ma+8sSsPKbhafevnt4wnZ7ILht3BfYBgBb9RvBwxmqWhHvvKGfyv57Gjz1KT6HYTo1uUeF9iWg2c2pTIVHKM/bl+29TTXdggqYNCc992J6Q1+Kx1jE7GryLhVL5wlZk69HmzSExpnDodI9o617TAPNvaayt2bc2GDimiwYMfSsPSnJQLOTM6d3Y98S3AtkDaZBbgLORbQuYN6ttEzR4rLdONvZ6wyLN/uRX3eLvxn//khgA/AgvFgilgELfoEktOnufBLsWFuGFZyKOylfzjoDbqQY4HbSnxxsmrjs3e18yFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:31:05 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 11:31:05 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Topic: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
Thread-Index: AQHc4+w4CBDzoNQQUUKvPHLypz96PbYTq8CA
Date: Mon, 18 May 2026 11:31:05 +0000
Message-ID: <136d277dba2ac681ed7607a436f55e2fd1975ec5.camel@intel.com>
References: <20260514215355.1648463-1-seanjc@google.com>
	 <20260514215355.1648463-9-seanjc@google.com>
In-Reply-To: <20260514215355.1648463-9-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|LV8PR11MB8606:EE_
x-ms-office365-filtering-correlation-id: 27f2c694-3a74-4c6d-afc3-08deb4d0f2b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|3023799003|11063799003|56012099003|18002099003|38070700021|22082099003;
x-microsoft-antispam-message-info: kGT0tbBpCVVuG2EHY8k4njRRYCcYHPYbF1yEivSvVH3Yc4NJq3legmEw7CvBDVEfFR2N4z+hgRwomAHpeLYfhjml4VPOt1CY0gJV7hyMqm+ZHuCgKykQQY+zAGz6Ie51hAaER9PK+3i+KX8vbuBa47++PhumECdXuFwsRS0gB6fHWNk4X0VRP0Aal3A7dDD+MVI7MmyWAJwQxyj1CoT6G6sjm7yA6F4bWbGsQVtGzyKAkNiJV555dXvurjbxuY7eIuvpS2uqfXx2e3eXtVWw6X1l23sFYUnXqrNpFhQpL5sr+G4HuA8X1rLTk5V+fp6gAb0diQqwQ3Zdf+wfkZn5Ljj3IOQ583aKwinnFFG/gA5H56f8UUIIdtzGvDIFGrYdNQTeQvo39x6e+aTHruAsHF2DPPvN8mju2+B7yHG5OG6LIn5N9avnRfz+kugzBYd792+E6q5JUmGcxsvQNeUCC2PhVsHvxfDxJsuMVN2w5Vg1OzLIZMynvtjMJ+kz5vsoAOPmMdhWW8XuQYdWgocrxknCwedBIR3Qd7+ye/VXif2fvJRk5LVWzOV04AeyrpGRIdLBRM9n2CK0Mxtw6TzKeo99nqBIQHdoV3CM/TouOdJwpNfD6qcZeurnWFJwB3CUpPjd7E2kNL/lzmYcMZk/I+LzlyEJo90Mc4fjtHq6+mDrQXStqRKuBOqaJ588NcJBr3R1hzPBvhFRv6UQaGt1koXfuJ8f7Nj/3DC42I7EzeNpVmVZ/5e6bZCaKYKPH73z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(3023799003)(11063799003)(56012099003)(18002099003)(38070700021)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnQzZmx1YnFBZXF5VDFHbTNsa1FxdU5kTWtxOWtPaVN2Z2ZEQ3hCTmlremZx?=
 =?utf-8?B?RGZQT2FVZFVwSi9zSkpEKzFtUzVhM1JPQU1yWWFVRHowdUhWVndleGoyVnYx?=
 =?utf-8?B?aFBxeHhjVFpuZ0JwSDUzUSt6UU9WaTBKMFBCbFVtY0EzRWVCczNGRXJWeHRN?=
 =?utf-8?B?cWJadUpLUnNkaXQ3ekJYVDFKeGkvb0ljb3FaU0NmZTRmWkZKcmNTeHUwd0lu?=
 =?utf-8?B?UlJOYzZvaFBzbktTeTYweEhaZ0Q4czUycHZTZitDd1EvWlp2ckt4MG5YZkNq?=
 =?utf-8?B?K3hDdU52T2lSWlN4d1hhRnFKTDN0NnRwdDJoS2x5dDNIZjNGNkFXNFpHTFpL?=
 =?utf-8?B?dy8xOU85SmM1QW0wa0NHRkFVL3FkSjgxL0NMcFN5MS96OHlLOVlFbXN1a20w?=
 =?utf-8?B?TFUzeWlnZUp6c1lIb2hqYWNxYkpxdHhnTlJjYXhaa2IxL2p4bXNKOXRyYTZn?=
 =?utf-8?B?RS9LZEt3WW0wMGxUUnZRL0YyUHJyMXVCanpLZzBNbWh5cDlvdjVFL1dQekZ1?=
 =?utf-8?B?dXZmenJRTUFUSEtNUDJ4QUdzQy9OdlN0MUFkVGswVkN3N09ZR1JPNDhzclpl?=
 =?utf-8?B?cE5kQW9ubjJmczdDMTJCOW9jOGNCb1U1Q0JVZzhlSG9NeW5LRU0wL0lMR2ZS?=
 =?utf-8?B?YndoemYwVm85OFNoNXdBVENnUzc5UzhTVExDVU82SFdGQkFRTzdGemJBdm0w?=
 =?utf-8?B?cGJ1Q2ZmZm5XcTlZTVhPUEh4VVlHOGdxUk9sc1Z1SWk1M1habkQ5REdsSWN6?=
 =?utf-8?B?QVI5QnZ2c2loT0hCOGQwQXhIQ2RSME9xbGplN2ZQZjVLNFRHcmJLL2xGN0tP?=
 =?utf-8?B?clRFK3JzK2dhd3kyQzMzclM2VlNpcXpTNlFVU0tac2lQV0svUVZCU2paU0VV?=
 =?utf-8?B?em1wOHdvaGtLOXV6c011SFBBZitrcFBEUWRsaXVOeUpkTkxaVnFTMFFieGlv?=
 =?utf-8?B?ZmlEdGRZZEM1UkdvQzhBV1g5bFdYamZJOTJhWUp6eEJvOWQvSTJiTkRMckIv?=
 =?utf-8?B?dWlzZTdsR0hMWHZMNnllTldVTVFZblR0allPREwyTmFZeEhOcGgrRVUvNFJS?=
 =?utf-8?B?SVV2WVR3VytodDlSMmVreU1QUWlXek92VWVUTG5zYmJSSUdHQ0dQTmszSGNU?=
 =?utf-8?B?ZUdvQzJmeWJQaWlkcG9aZ1pnT3JCZzcrQUVWRGZzR3l0bWtMcmxPSmNXSnRI?=
 =?utf-8?B?Z0FEUFlyV0N1cFBieEp6YkRkc3pGei93TWhuS1dDTFoyYU5XUi9tNyt4M0Fp?=
 =?utf-8?B?dFVrenlwUmVLQmg1cXcvTjYwenVWaGZQa0JraWFnQzFZaGNReVN3Y3lPb2I2?=
 =?utf-8?B?ZDVUbmxUQmhVMHdQL1F1RmprMC8xWE0ycFZNd2NYWGNhak1USGJVN3B0K1lU?=
 =?utf-8?B?dmVEZDUyL1ZXTmNPenVLTFREMUVYWmV1VTdaMzVpcTBPbG1wdDNSeW9jUTlz?=
 =?utf-8?B?USt6UTN4UE9ET3BYbFp6c3g0M1hjR1RpZ0ZqSTMzbzgySnd5Q2krWlQ4dlQy?=
 =?utf-8?B?RDYvcXhZUnVPektrVUo3U1lwb0JFSGRzTG55b2NzbGZZK0RCNXIvUk1LWk91?=
 =?utf-8?B?WndhajNGTHJjWjRzVEFXVEl3ajVYWTQ2WkhmVlBPZnNMYXdCenJqYmN4a1Y5?=
 =?utf-8?B?REF5bEFOYjgvZFloeEhrc1J6TEsrZGVTb1ZhVEE1eHhXVmN5SVlTZUdmRTQw?=
 =?utf-8?B?cnIzS0plZ0dkeXlHUUR2ellyQndhYm5HMmpoK09WeDdzalJtclN2YStzTzZL?=
 =?utf-8?B?cU1rS1NzZDJscmpVR1BkTTBFQ0hNWW4wV21BTTBrSUxBREJSRjZtSC9DZUp6?=
 =?utf-8?B?VGszNVFqWXkvYkJZcUpQZVdNMi9hZnp0by9ldkxIWm5ySC9SSDRDR1ZUOEVv?=
 =?utf-8?B?YThwcTVqaFRsa3BPMWZRZ3VjVVJzaG5OZGpsa25rNVUvbmU5ZTFqZkRtUWx1?=
 =?utf-8?B?WkdKR0twc0paWklBMlp2N1NXaGRMVWZWdk9TYytIVW5PWFgzNGYxRVhZRkF2?=
 =?utf-8?B?M0ZJZTBXSExiMnpsR3UzcW4xa1dBY0RZMjhsRi9mWHE0R01yZlJPU0V0ZVJa?=
 =?utf-8?B?V2Uvc1ZCVjZsOEw3a1Nhbm1LanNUM054dEpieVVJakFCanRnYUFFNjdSaFhz?=
 =?utf-8?B?OFFSdGc4K2d1VUdEZVRuajFDSHpuYk5UOS82NVhFV2wxcEcrSXpaU01nblI4?=
 =?utf-8?B?ajlvVWw1dTh6clFQMXU2Q3V0anN2ZGdEdVlUa29RenVRTnZWRk5NLzNrZnNX?=
 =?utf-8?B?WENNalBpMlZTQ2lOdVZxQ0JEVHRldjcvbjZsdXNQcXd5QXRQTGlZVk9TU1p0?=
 =?utf-8?B?ZG40K3Rkb3NIQXFzemZMOGxFWjY5aWp1dzZqOGRrRWt5YnFFeHBldz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8721FE93C68C4942A60273C8F0D32DF3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ewMT00RER5/JyUdj1tN7gLIa8/yMg5818xDnvrdYN6r94xGwjyjqxAaQ298GI6Gs+fr0/rwH8IT1WbEBC6c1pH96hpJARJ2mdwe+jx3DcWi5vYS3hcjn7fzeisX2dQewRxiWBMYVqI2eaHpahY2jVAbKzhOFwChtKUzuRi3l2byj+XtyqOZibCki4TyoSEm0JEbKHBX16hBMGqeUvvy7mQsEjC0ImKGqrNJ9fhM7NHJnJlw4+lK6TNVp7xl2ELdmHe6fUdZPx6sfPv240tALI8wWeLRaBE4qKRfS8CGYz9mX4tyRvN1TQbYWHC7sEMHmwGyz9nyhDNxWsH+dsMRKEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f2c694-3a74-4c6d-afc3-08deb4d0f2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 11:31:05.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iVh2gidkeS8uLhtrATEKPG7jTMTWAAAiQfasjCk4fvsBtSd+XY9QcMlVfCw5Y3jOgCzE3wmYEx64gG4WmgOuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com

DQo+IEBAIC0xMDQxMywyOSArMTA0MTMsMzAgQEAgc3RhdGljIGludCBjb21wbGV0ZV9oeXBlcmNh
bGxfZXhpdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+IMKgDQo+IMKgCWlmICghaXNfNjRfYml0
X2h5cGVyY2FsbCh2Y3B1KSkNCj4gwqAJCXJldCA9ICh1MzIpcmV0Ow0KPiAtCWt2bV9yYXhfd3Jp
dGUodmNwdSwgcmV0KTsNCj4gKwlrdm1fcmF4X3dyaXRlX3Jhdyh2Y3B1LCByZXQpOw0KPiDCoAly
ZXR1cm4ga3ZtX3NraXBfZW11bGF0ZWRfaW5zdHJ1Y3Rpb24odmNwdSk7DQo+IMKgfQ0KPiANCg0K
Tml0OiAgQUZBSUNUIGlmIHdlIHVzZSBrdm1fcmF4X3dyaXRlKHZjcHUsIHJldCkgaW5zdGVhZCBv
ZiB0aGUgInJhdyIgdmVyc2lvbg0KaGVyZSwgd2UgY2FuIHRoZW4gcmVtb3ZlIHRoZQ0KDQoJaWYg
KCFpc182NF9iaXRfaHlwZXJjYWxsKHZjcHUpKQ0KCQlyZXQgPSAodTMyKXJldDsNCg0KQnV0IEkg
c2F3IGluIHlvdXIgbmV4dCBwYXRjaCB5b3UgYXJlIGdvaW5nIHRvIHJlbW92ZSB0aGUgbm9uLXJh
dyB3cml0ZSBoZWxwZXJzLg0K
