Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3106257855;
	Tue, 19 May 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153773; cv=fail; b=U6Jm5NmcxQvfopDGs3yv/zBOYOOFQpcikhcnYOZRbxQGx5FDHWMoSii7QliawN+/EaVLiMxEdqawx+E/oWeDCZC2ZVa/YtTHusIFe1LnYUFf1YQx0TN2lC129nZ8KZELlggx25IhGTVDkQJC3DQ9C2Uzi/N9NMB7Twb/R6nC8ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153773; c=relaxed/simple;
	bh=FLmwyLqatNEVmtoi2pkO4KItIFDsLI+NOQqJK8DuLGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aa1xFdKzwzAj0mz4LE2WhuvoTM9R9ujCSKZXc1j6Qi1jNV3CNzYnnjPJbtYMm1WdteJpU4c85CeuA2xGX2qWwhO3CLHRbysSfGm7vk8jeX1CvEYgZ7rZu+V1CD5NPP3xaaazCJJKJjqe+4PsdCfLe8/OBdio8GUf6zgswIyVOlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/+Gw0sZ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/+Gw0sZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779153772; x=1810689772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FLmwyLqatNEVmtoi2pkO4KItIFDsLI+NOQqJK8DuLGM=;
  b=Q/+Gw0sZgdGVCF4grXhDaXITMwPoq9sTsKhHtBPKCy7JZcRH3SXrAKdn
   wA5buP4l7+zwyPLH8M5IuJflAhHMD4mI5y/9vq/Wjg89gjqlF5rcqP85H
   OmO0s1WWIQfLhTj8g9yUk1rBQqXJxCg33xmqfyfjy3qRTBM4ia5WU7YIo
   xORc2mSlzRZuJs5Ei78JxcRFDUOuabTeeTPhsC8Kx6HHq9PGsrj2+HhEg
   YttPsz8cT5EWhI4Vauke0J/mSzypQdQ03g39qLTe0yU/T1BuoesiknHFR
   5HCuDSysBE06Vym7SmzcNV+PRcxa9SlqUVqQDIRvY6bjTEUnTXX0hMiRK
   g==;
X-CSE-ConnectionGUID: 4vHfUeQ2SGeM2STc+G64pg==
X-CSE-MsgGUID: qZ8pat/tTgeKyPwhM1WwzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91127767"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="91127767"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 18:22:51 -0700
X-CSE-ConnectionGUID: +chBfKoITk6XvlfmuzlPvw==
X-CSE-MsgGUID: O7LbH3nyQnSoe0owYB2o6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235157716"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 18:22:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 18:22:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 18:22:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 18:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCDQFoStb27C+8oZC8YilOQp1QaM74EDQ7noFPzP9NvbrmT/FR0J7nel6JrE58EE6m7PGuSVj9q/Gl6rySewAVLStjlWV+M4/rYExVcJFIjLHMO/kCReCzJfxccko1axpk2mfWul/4f2ai0z3H0bP+O9yXnZ2yCMTyiKvcr+2ePxQpd8AoJEUybKq7LZ0fsbMD3dl7VPQ3bTI33PQKXANiKs/UkN83rxmeB7sJptFkAAN5otFsXH4icJ3VQgBA2KZzhsTywTo+7AEQzubEkuWd41CSF6e0ePze1Ld6eeQyCAjt8btDimWRFgik9X2zoPcQKs4lBGEjpovAnaq8w3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLmwyLqatNEVmtoi2pkO4KItIFDsLI+NOQqJK8DuLGM=;
 b=TfoRlfN4ZrKxyq2qy54lb7Z5XuiHafpkNxDaw49YgntcKG439cjcw9DluxzXBBp6Cqnnbp2D/mMgJyAjxiTqHpr0ttmqDRNqLmNv/7H+VnU1WX3x+pUAIzOFAjaa1aHpXGBZTC8BbiJN4wSdFv5U/iPmauwgPn52wC5KWklxfmSiZiee/pf0kU3JJXQFkyAdHMptcMFO8ZvL/lJk1biL2LSucyTbvb/AD6Dfeykty1WducCaispv2T51XldLnnSLaGpqKwcvkI/VfRiUityjIGqEMmm/mAZWEpZBdJw6bXo91eqhnG9+3QSxdSyvjL4Y8DXX2ZtCjmovqMmBjVXFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.24; Tue, 19 May 2026 01:22:43 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 01:22:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Gao, Chao" <chao.gao@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Huang, Kai"
	<kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "kas@kernel.org" <kas@kernel.org>, "Shahar, Sagi"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v9 09/23] coco/tdx-host: Don't expose P-SEAMLDR
 information on CPUs with erratum
Thread-Topic: [PATCH v9 09/23] coco/tdx-host: Don't expose P-SEAMLDR
 information on CPUs with erratum
Thread-Index: AQHc4urWM3oRHc6vskyUkaoByWYPTrYPWgyAgARoOACAAC4UgIAApcwA
Date: Tue, 19 May 2026 01:22:43 +0000
Message-ID: <1b9d865cad244b4f16837a504f469dddd70a6eef.camel@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
	 <20260513151045.1420990-10-chao.gao@intel.com>
	 <f1057429-4918-4b02-ae17-9bd6cc38a3c1@intel.com>
	 <agsJpjZU0kbsY3oy@intel.com>
	 <2e082f23-1383-4dba-8cdf-0df612f64ace@intel.com>
In-Reply-To: <2e082f23-1383-4dba-8cdf-0df612f64ace@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM4PR11MB6214:EE_
x-ms-office365-filtering-correlation-id: d95bc450-7a50-4234-c224-08deb545206f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|11063799003|4143699003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0pXHczMYkEKTt8jui2J256Da9lzGeLtNdnXxWqHicl6l+QFG70+FHqUhyn56i5SpZrkZWQmY3wlwaZ15HDQZruAgTbV8rbu5viLqIIcxnGhbLqrdZ0NphMrfbso2U5hZP/Tf2vhy/V0B19WBDnSo10zy4dawDlJo37FG4Ot+f8bqT7BdYxaQhvTyGmPW0IwiKoyj6m61HGW8Y4bnosYom4QAfY+3C1cXkZW01UJrFgXntavDCeZmfqjWORsYSGImxDRPxgGUy3d/gMPgjxGINIwXWqKfKU5b8uwlk+KQeHL0eMZnhI03yv/AMCgtsF6omNSOHeZs3mqLtIlR0El0ZTNGPgqPL1rFvLRCLFDDdqCLBFddN5yOYaJBFL/hNNnT7VSEabkUnqWiclpCkDBkT3iDms8xL9f5TJFVj27PQ3T9QZWnYCVJW3YSHp82Pr5gVxCWvDef6zOPIjIkuHEl4+zYNALDHOmzy2ZvJb4RmynqkslZsNSOQH5pe67SHPCqyanUzRdg2faTopFkdcqmhtu03QTHgytQUDn8GveaFfCpIDkHJh4Y9RAR+xcbDs6ArpehJ47viRXoUPpkUxSE+z5kygoEonFvdQQcgPRh+YjOtrSJ4TdmENVh10BWTSLrje05aVSfMBjqyO+85TlV+Io7gPvbq+5iySkZFfDiAb0ctvc02rVndFGrauNqsCkPOszY6iR6K4lv6Dj/kvOsYbwyAHlqSku0ZWNl+FkQd8cC5hPy/a2XZCL7HtfyDWng
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(11063799003)(4143699003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVZRT3JGR0dJTFdxNHNRWVdJK1RhR1c5Zy9IcmxlWXZhV1paN08zQm9OOTJt?=
 =?utf-8?B?NGRWVzVIMlRLTWtFMWRBeTRCbzhvVkYvVmcvVGU0dGc1aHhCbGZ6U3VVazE0?=
 =?utf-8?B?RnBxRE01MHJwWHJVaS9XYTdtS0l4OHVGMGJkMFdkSUtrSnhVY1UwQkJ5eHFM?=
 =?utf-8?B?dWVmdjNNWHFJclhFL1ZGMjZtVmZPc2diVGxyN0ZqbXRNMEVIU1FxRk81QlV4?=
 =?utf-8?B?QVpMSHpPbVZBb3U0N203VkJ0bUV4TUx4YW5SUUZDSzFPTVRUYXJvSUhpY1JM?=
 =?utf-8?B?Z0RnSmF6L1BqSDN0SWFhUXkvZUNrK2xpZFd3YUQ4bnVaV2RtR21MY3pNeGRK?=
 =?utf-8?B?bEZacjVwYndSdDBNSnRPY1RNcmpwYXVNSjh4NHhjVVZYT2ZMbGdqVmRXNTJo?=
 =?utf-8?B?cml3M2FHYVlseE5ITHY3NDZneGU4SEtZTWhsSkhMNmJoaExDZ1dhdFpSTXJx?=
 =?utf-8?B?MHVsSTg2TU5CcDBtRFpCOXJVYng3dlhaWjNVWGRoWk1lQzJxeTgvMUpKTko0?=
 =?utf-8?B?c0lxbldmZWNTWGlnU3N1Zi81VU9uSUVYWGZpbkRRZkRMK21Sa1dSbjl5Q2Zp?=
 =?utf-8?B?M1ZkUTRGOHdlKzNxclFTbEtiT1pBWGJOQW94bW1zQ3JQeEdkSWpBSUNoTU1s?=
 =?utf-8?B?TWR0RkFHczNyODFYTVowaXpVL0VsWVd0NUx0UW1Sa3FzM0NkNGUrRDRZWXhD?=
 =?utf-8?B?dmE3NWhQSnNrRTNaVEs1K0RjNEJQcUVxRFE5cXErTXJwMStMTHhvY0FJdml1?=
 =?utf-8?B?Si9Zc2g2eXl1b1dwWWZPUVdyWGtuM2huLzgrQVNzVEQ4OVMvd0RINXNMTUta?=
 =?utf-8?B?d3hvc2JmMlJEOExlV0JRODB3RWkzQzMzNWR5ZnRXUGRLMzB5TnVheEpSQ2Er?=
 =?utf-8?B?MDBxTU1RQXNmY1Z1YU02bEd1dVpoUGt5NVAvdHZsb0pxUWVHQjhSeUZXUFVh?=
 =?utf-8?B?TENRWDQrZnFtekNOSCtON0JqRGNaeGMycnY1aDRiNXlHdEtqdG1wWGh1ZTcv?=
 =?utf-8?B?M3JzN2h1akxhRk41T1Z6c0RRcnZGbDFGWkgreHVrSnowUkdsT1ZaWnF2SU11?=
 =?utf-8?B?c3lyOFdxOWhPMlAwSjB3VFErV0piYkFBUG1aazdLa1Y4Rkp6cWVnMXNzbG5m?=
 =?utf-8?B?enU5YlpmSDlNZ2FqNzBwQjl0UUhIZmhaVzM1d0hzKzg2endHL3pIY2YwYkFJ?=
 =?utf-8?B?T0tZWktWWEtaTzc5MDZLZ3V3VkpiNStiQ2FvdkU1NmppMHZnbmtnMjJyK3Zj?=
 =?utf-8?B?SVFNVGVncHJ4ODJNbkptSWRWaktpbVY2WCtSdHRoVUU1cDhKYWpXc3pBQUZh?=
 =?utf-8?B?MDczUVVWandnTHpOa3ZmZlZwdzYvUk1OMERodmxSU3J3YWhLM0lCemJPUGF0?=
 =?utf-8?B?QU5DSzcrZjRYNjZTcEZWREFNSjY4WW9WRHIzTnRtbEZPWEFtK0tmQXZrbDNI?=
 =?utf-8?B?K3E4d2RERGx4cXppenRoVHVKeW5RdzVFTWxNWXBUTWtrdmExUFZlelN4Wjlr?=
 =?utf-8?B?cEtLYlRVN1JJVTQxKzR0OENiTG9iUnBUT0d1OTFuK3Npc3lNZUpXd0I1azVS?=
 =?utf-8?B?dU5YcEZFT0NZRFhnRGcyWTdqbDBkSnUyMCthajVnM24vMGx0SEQwMFZtaktO?=
 =?utf-8?B?c2h1T2hHdS91SkRrUFNUNi9TQldFa2FtL2srZFVsNy9ZcjgrWFBNK1NuVW0y?=
 =?utf-8?B?QkwvcWgrTmZFTzBmMDBPT0hENDVtRU53YWM5cEd0ZFJndFFWdk5EWHRBT3dv?=
 =?utf-8?B?MlRFUE9CbzBYblRVOWFoRzdMVGNhSmFkR3VZMlB5N0Fadkx3Q2NWZXpXNDRU?=
 =?utf-8?B?eEtNTWRTb3hMSUdmVUZKSGF3d0pSYWFpZXk4NnNmeTBRTDc1V01HV0J4ckZm?=
 =?utf-8?B?K0p2QmdBNGxaMTQwTEJEQ2hDSlREY045bkVUTTdEQnN1UzVyMmZNWUlrK251?=
 =?utf-8?B?VDVNZFoyY2l2Rm9USmhWZnJiZGZwYU9TMmF1VFNIR0UxWWVXejFhZkNueHF1?=
 =?utf-8?B?WXJQMjRKZXArRUpXNy9iRUhiVkJiaUtEcTFaUG9ZMUhmZ1JpUHJyWWZsaXJW?=
 =?utf-8?B?azFVc1kwcitQVUNqNG5CSEhLaEg4SWROWkFZaG11dll4RlVaUXFRemxCNnVB?=
 =?utf-8?B?c21QbTA3YzJYRE9qL0VGQ1VIZFE1SThITXU5RVhqeDJKVURzcnVaWXhrcCtr?=
 =?utf-8?B?RnFEbXpZb2pEckdOTFZtbXkwOGdZbURKMDVhRUcvUStCekdNU2RFRG4vMzhx?=
 =?utf-8?B?ZmhZbVZraXdFMjhRZlIwdjhuYTJ4SHhkc25XSG4vd3NheGFlcnZuOHptNGRM?=
 =?utf-8?B?RTdKU05vbkFTQXdhVGROOXZoOGhmam5jRjRRSm82akprYTVTWWMxVnVTbVNt?=
 =?utf-8?Q?AydzMsaFIziKUY0A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A77867002E6AC4690919C8C3ECED83F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jlpY7Ht8YBA9E3kQgny1h7PEQ5nSAuc451ETdPv9IcHfIumE4mraevvBNMY9rPoOyn/HArsEFBaPSIAG4hHQK6W+a3tCHeXcA/FjvWP7nOgk49UCavkGZ0abI/3f2J82sFFNgmxjQdFH0YzA5pkM1bxF88Fekh5tgcma4Sdz9zUAwTLokzV1jxAJ8gj3HhQaQ9V5z4LYmOhYNkQRqRyn/XFd3MSm8+w8+BxtG9CSP+pQB23js/HbLeDi/x3ddjjPZpLqQy8lH53mH1Xw5k1JnOSeUWY1d6XHnc4sLBIGkoBmIUKw5Q2OHN3lEbuTeuHcpM27pXh0ncb841na9oNS9g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95bc450-7a50-4234-c224-08deb545206f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 01:22:43.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyFjPyXULXjdNlkoGLUC6ijkPagpdhY0gp99BtMbjP1zDsQGmbpuCfMwb1T/7lfPuPd4u7j0nDxN3It1b9WKMvokOYC1KUZR/Q1cbbaslIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA1LTE4IGF0IDA4OjI5IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8xOC8yNiAwNTo0NCwgQ2hhbyBHYW8gd3JvdGU6DQo+ID4gT24gRnJpLCBNYXkgMTUsIDIw
MjYgYXQgMTA6MjY6MTlBTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+ID4gPiBPbiA1LzEz
LzI2IDA4OjA5LCBDaGFvIEdhbyB3cm90ZToNCj4gPiA+ID4gU29tZSBURFgtY2FwYWJsZSBDUFVz
IGhhdmUgYW4gZXJyYXR1bSwgYXMgZG9jdW1lbnRlZCBpbiBJbnRlbMKuIFRydXN0DQo+ID4gPiA+
IERvbWFpbiBDUFUgQXJjaGl0ZWN0dXJhbCBFeHRlbnNpb25zIChNYXkgMjAyMSBlZGl0aW9uKSBD
aGFwdGVyIDIuMzoNCj4gPiA+IDIwMjEsIGVoPw0KPiA+IFRoZSBURFggSVNBIGRvY3VtZW50IGhh
cyBub3QgYmVlbiB1cGRhdGVkIHNpbmNlIHRoZW47IHRoZSBNYXkgMjAyMQ0KPiA+IGVkaXRpb24g
aXMgc3RpbGwgdGhlIGxhdGVzdCByZXZpc2lvbi4gU2VlOg0KPiA+IA0KPiA+IGh0dHBzOi8vd3d3
LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kZXZlbG9wZXIvdG9vbHMvdHJ1c3QtZG9tYWlu
LQ0KPiA+IGV4dGVuc2lvbnMvZG9jdW1lbnRhdGlvbi5odG1sDQo+IA0KPiBJIHRoaW5rIHlvdSBh
cmUgc2F5aW5nIHRoYXQgdGhlIENQVXMgaGF2ZSBhbiBlcnJhdHVtLg0KPiANCj4gVGhhdCBlcnJh
dHVtIGRpdmVyZ2VzIHRoZWlyIGltcGxlbWVudGF0aW9uIGZyb20gdGhlIHNwZWM6ICJJbnRlbMKu
IFRydXN0DQo+IERvbWFpbiBDUFUgQXJjaGl0ZWN0dXJhbCBFeHRlbnNpb25zIChNYXkgMjAyMSBl
ZGl0aW9uKSBDaGFwdGVyIDIuMyIuDQoNCkl0IGFjdHVhbGx5IGlzIGRvY3VtZW50ZWQgaW4gdGhh
dCBNYXkgMjAyMSBzcGVjIGFzIHRoZSBhcmNoaXRlY3R1cmFsIGJlaGF2aW9yLg0KQnV0IGl0IGxv
b2tzIGxpa2Ugbm90IGVhcmxpZXIsIGJlY2F1c2UgdGhlIGRvYyBzYWlkIGl0IGlzIG5ldyB2ZXJi
aWFnZSBvbiB0aGF0DQpvbmUuDQoNCj4gDQo+IEJ1dCB3aGVuIHlvdSBjb21iaW5lIHRob3NlIHR3
byB0aGluZ3MgaW4gb25lIHNlbnRlbmNlLCBpdCdzIGluY3JlZGlibHkNCj4gY29uZnVzaW5nLg0K
PiANCj4gVGhlIGVycmF0dW0geW91IGFyZSB0YWxraW5nIGFib3V0IGlzIGJyYW5kIG5ldy4gSSBq
dXN0IGFza2VkIGZvciBpdCB0bw0KPiBiZSBjcmVhdGVkIGluIHRoZSBsYXN0IG1vbnRoIG9yIHR3
by4gVGh1cywgbXkgY29uZnVzaW9uIHdoZW4geW91IHNheQ0KPiB0aGVyZTogImFuIGVycmF0dW0s
IGFzIGRvY3VtZW50ZWQgaW4gLi4uIE1heSAyMDIxIi4NCj4gDQo+IFRodXMsIEknbSBxdWVzdGlv
bmluZyB0aGUgMjAyMSBkYXRlLiBZb3UgcHJvYmFibHkgYWxzbyB3YW50IHRvIG1lbnRpb24NCj4g
dGhhdCB0aGUgZXJyYXR1bSBpcywgYXMgb2YgdG9kYXksIG5vdCBwdWJsaWNseSBkb2N1bWVudGVk
Lg0KPiANCj4gQ2FuIHlvdSByZXBocmFzZSB0aGlzIGFsbCBhbmQgbWFrZSBpdCBjbGVhcmVyLCBw
bGVhc2U/DQoNClNvIEkgZ3Vlc3Mgd2Ugd2FudCB0byBleHBsYWluOg0KMS4gVGhlIHByb2JsZW1h
dGljIFZNQ1MgY2xlYXJpbmcgYmVoYXZpb3INCjIuIFRoYXQgdGhlIHByb2JsZW1hdGljIGJlaGF2
aW9yIGlzIG9ubHkgZG9jdW1lbnRlZCBpbiBsYXRlciBkb2NzIChyaWdodD8pDQozLiBUaGF0IGl0
IHdpbGwgYmUgZG9jdW1lbnRlZCBhcyBhbiBlcnJhdHVtIGxhdGVyLCBhbmQgY2hlY2tlZCB2aWEg
dGhlIGJpdA0KDQpNYXliZSBzb21ldGhpbmcgbGlrZT8NCg0KU29tZSBURFgtY2FwYWJsZSBDUFVz
IGhhdmUgYW4gZXJyYXR1bSB3aGVyZSBTRUFNUkVUIGNsZWFycyB0aGUgY3VycmVudCBWTUNTDQpw
b2ludGVyLsKgVGhlIGJlaGF2aW9yIHJlbGllcyBvbiB0aGUgVk1NIHRvIHJlbG9hZCB0aGUgY3Vy
cmVudCBWTUNTIHBvaW50ZXIuDQpIb3dldmVyLCB0aGF0IGlzIGEgcHJvYmxlbSBmb3IgS1ZNIGJl
Y2F1c2UgY2xlYXJpbmcgdGhlIGN1cnJlbnQgVk1DUyBwb2ludGVyDQpiZWhpbmQgS1ZNJ3MgYmFj
ayB3aWxsIGJyZWFrIEtWTS4gV2hpbGUgdGhlIFZNQ1MgY2xlYXJpbmcgaXMgZG9jdW1lbnRlZCBh
cyB0aGUNCmFjdHVhbCBhcmNoaXRlY3R1cmUgaW4gbGF0ZXIgdmVyc2lvbnMgb2YgdGhlICJJbnRl
bMKuIFRydXN0IERvbWFpbiBDUFUNCkFyY2hpdGVjdHVyYWwgRXh0ZW5zaW9ucyJbMF0gZG9jdW1l
bnRzLCBpdCBpcyBub3QgcHJlc2VudCBpbiB0aGUgZWFybGllciBvbmVzLiANCg0KRnV0dXJlIGRv
Y3Mgd2lsbCBkZXNjcmliZSB0aGlzIFNFQU1SRVQgVk1DUyBjbGVhcmluZyBiZWhhdmlvciBhcyBi
ZWluZyBwcmVzZW50DQp3aGVuIElBMzJfVk1YX0JBU0lDWzYwXSBpcyBzZXQuLi4NCg0KDQoNCg0K
DQo=
