Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEB30F816;
	Fri, 20 Mar 2026 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028935; cv=fail; b=nWFIFfim5l+o0vZDXrFK59asjG8eO+i7YxzE5xuSBxarvAxeHeFezsF2fc/66Jk8qNTvtfWHqpcaylGGGzYzFwICzucDvU0a3pRuEszeTiUwnnVzZ4mB9esb22EqcJNYzhFmPf34N40O9VbTl6DYny8patCmnrQP7mMICFSOJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028935; c=relaxed/simple;
	bh=xHBnyZWHJ50bHZKSFn/7H1y5Z1Dmr0Dn1uqodOYxMXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rHOC6ubY/k7sk4F+OWrVW9hVEPOZN2cRMEYC4zODObtd9yQxXaP4/8+hOVInNEynFVIOjThfCEG5rsvJHmd0DvoveCzN0T+jQEUaGk84E8MPv7ObrbGqEhZiM1TAuLvii9k6rt6Bjv6+dO8cev5ejFHP4hbg09tpGX94Bao12Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3zY8JMG; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3zY8JMG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774028931; x=1805564931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xHBnyZWHJ50bHZKSFn/7H1y5Z1Dmr0Dn1uqodOYxMXA=;
  b=S3zY8JMG5vR0oIu6Cue+zsoW6VtvJ1ltXr1SHeVqNZyGCw4KRxYURCyO
   L68/yVRu26FWWBFw47E1Aa23Znnio39+E+7iSpF/8AOvVebUlyQAXa4E3
   hklAMtAmEQxv5VV6Fh+rFO1n0DaZTQGhLLwjLJwml+mnKmHiWgr/l6sEp
   Aq7jHrYe1YZPdFKZk1zqyHFCcxMJvBegrtYIm2QaNWTZToe5posVSd75o
   4Ke/ytQ8zOwxgAnzIBLxAM1eAm220uCfZG8b+RvgyuKq6F6wpN+t8Yc3A
   VZyJqcb2yauCJLSlAuW8cJratVTs6JZ9L+VJGXeBIkYYothY1p2rlgQX0
   Q==;
X-CSE-ConnectionGUID: EtHgDLhlR9yRF8m3P/mSiQ==
X-CSE-MsgGUID: o2LBX5U9TO6wBV/KH9EWgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86483717"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86483717"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:48:50 -0700
X-CSE-ConnectionGUID: XWqitcGcR2+TTqGgJW9t+w==
X-CSE-MsgGUID: zXKBALQXRsKeZjoPAGoCWQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 10:48:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:48:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 10:48:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 10:48:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCg96DgtK44CAW6jmjVgWwt3PnSfwgOGG1MI7iK/+8qhrbswusKHommfGjvwAMhTdnL6jaPB4kfCsZ1L4Rs+UKuPGQSvOrHFbyu+XET10iCJXH4e+xY0nFh5oi2Nsb1+GtJibjLKbxDA9R64WPCRwn0WwpO0SorhwiUG143gjewJ09tLWN05sLWyKmnLG0ZTsbhTpgkSJB54kYiKQcw2czrD+nUQTsW7DPBjUueeOcT5kkQLg4MEvKnOajeqQ5X4ZqkuSCjsaraQ9TpViejWZaXh7q77jsL27aLg0K8zOkmvpW4DnKZA9WKaYJ0oivFgW2SeoBxlz0+W04fpB1r0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHBnyZWHJ50bHZKSFn/7H1y5Z1Dmr0Dn1uqodOYxMXA=;
 b=nlqJMhZIOwKqcYI576phbo3fQhnBorZyoJwypS4QffBrHsyFf7EgxbY8wMl1pZSbj/rGJ0XznfscwTRY0GA4WFJMHn4nw/WYWUoTFtzhmFePkHlxfwcTGhCLxoM3lnviH35bqrYo0wIcB1yiRM2hPgPDXlGeGkgWDWhHKIhL2Xk5tYcmFsAX1M6u+7c8J3iK90ugBX20IaAmC2QLFWEsMrQyFTN+evgffcLSSWXJRLtRIJOxeQW6fGY9bROPB03Hg9nwZhbFn/B0PFdJsFBNcKeW5QpndzS9GnAz3gofaoLTjnqiffyHHEeaNH7AZPSA4Jc1max+rsbDUh6V/DfEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB8525.namprd11.prod.outlook.com (2603:10b6:510:304::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 17:48:46 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 17:48:46 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "ackerleytng@google.com" <ackerleytng@google.com>,
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "sagis@google.com"
	<sagis@google.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Topic: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
Thread-Index: AQHct0DWySj+AXH+Kk26T1K2yM7v+LW1qsAAgAAWiYCAABAogIAAS3WAgAFHTACAAEwDgIAAAfMAgAAC7oA=
Date: Fri, 20 Mar 2026 17:48:46 +0000
Message-ID: <981366580999bbcd5394f30a0e23fd62d54bfa42.camel@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
	 <20260319005703.8983-1-yan.y.zhao@intel.com>
	 <abvR2A19S4ZtpAli@thinkstation>
	 <abvlOcnY4assk8DW@yzhao56-desk.sh.intel.com>
	 <abvxiuJfK2eM_1UX@thinkstation>
	 <e3acc801e4e939a0a4794ba777e72f26b27af0d2.camel@intel.com>
	 <ab1EcZ3G_Nc-929X@thinkstation>
	 <d614658f2d1f3213b0d8ed404c51b3c4bfbe5d7d.camel@intel.com>
	 <c8c15f0c-6fd4-4a1f-98c3-58467b46afe2@intel.com>
In-Reply-To: <c8c15f0c-6fd4-4a1f-98c3-58467b46afe2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB8525:EE_
x-ms-office365-filtering-correlation-id: 0155a902-b56a-4d76-4f6a-08de86a8ef99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: jA0Fl5ESzjv2KS6+Kj5s1rUBHHjrYbKmhVYxnEHPyG0dJ+NHMbnYMoD3+KNhhgSBAsh9u2WGiCet0Bp/v3MzGR/+hSBLFvfghDGHI9+vF0VCtG5t7X3jQk4LmfBLrLlwQwM+UBx6ALY8FZKVi6u9+AfiHj+j711V/sWSbZMk9GX3gX3Zgd03p+6jNm77FrJO98lI0jcCnG+5qriek+nwxQwMnHiofKi+7w9IBrY1JYzXKGHQhGAvTXSJ7qS0Kt4d6WsN7agm2W3TAZ8loPYByHSCKC6P7PX4SxyO6NEsXL3k/xMeaSVy/35BXsvDgbwPVVpI6pHdXoaVoafs/xIo6ZvtQ7Qw4KZxsKyp8ya4Cb3lZEKs9//eh//pwqJZr7n5xlWtHjTy6be0OUku7DyC5L/RzX5Vur4f1ZyhGfLKIip1IcT2vUUezpo8EqUgUyRZLP0cWE0cgZtLXhem0umcVwjunFjc/BgzbT2FDKXFJ19WsZ23XW8S21Od3n7ZOL0LVUG65DAp7McBstv3XIiZJ5BHiYV98hs3BrE/LjPihu4y6nKVnmrUAR1E6MisReRKDFvoTqOGu+LQD/vol0hH5Wuogue44J/gFFgO75b5xlXc+/nvobisNMtcvXoSPcDW/fbGWpSa+VK8mG7v5Y+J+QoQxzyF6eW4U8k35wgejSk5/BnjSK3ad9o1iwt/NFN5j0d8l2FS+2+ZXcp98qR6VpyYsXIBSxgBkTYoiJyO+1nN44eF/2ocHgi6DPg9ygX339JujCpwKN92qPsnfD258yw0Y/1w3vJtCEWYQxApti4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm11MTJFRG1qUmgzSTJmTldOVCsvZVE5TXFBN3BTc0RLcm9jOHdxcmdiTWcr?=
 =?utf-8?B?dTdHSWlFek8zSlZZOVpYY2xmbUlyZGRyWFQ4ZEc1ZXdWY3czc3RUWG1GRk81?=
 =?utf-8?B?Q1l0aDd6ZnJsK2Q3YnV3MDhLZmNaWjNtWmVXRit1MWJHa2t0c3d2RlB0VkYz?=
 =?utf-8?B?dEZEMnM0Y2UybVRaWjJFdnEzUWtPeEJKZWYyVVlFWmdLVFJCcC9DMEtMUDhL?=
 =?utf-8?B?Y3hDeXlHN1c0bzVYdmovMGZLSGt3VDNReCt6L1BMa0E4NEcwWFpMU3FlVnpn?=
 =?utf-8?B?S3Zrby9UZlVFd3NXVENFSDBVcnkzdVY2S2tZRmlCTXhEZ1VoWjRwdDJvVUp1?=
 =?utf-8?B?czlybHRjYWhBcXE5TWUwNWRTa3dtKzhUVVpBYmx2KzJxTEhkSTBNR2dmMXlL?=
 =?utf-8?B?eitzLy9MU25WbUVaVi9WbFFuajBDM01tWnB5WWQrcDhWV0dRU3ZLa2RSdGd6?=
 =?utf-8?B?OHNEc0hqLzdaaVZqRFZhdThIK2F1OXlZRUYya1R4bko3SjhZTlRYc1ZYN1M2?=
 =?utf-8?B?bjNic0swTUxTLy9sRkdoeGJUSEtvVjFyM1BYamdKUmpTQm03NTB0QTZNNDF0?=
 =?utf-8?B?aEs2YzNFTmlDbkNRbUJmbVVPcXFzYnRZWjB0SkdpQzNKR3MrQ3VNZjZ5TGVL?=
 =?utf-8?B?S2ZXeEp0T1dnSUkvaE54dVhlamFmNXFSQjIvbUdtbE5CQnZYenpFMVlXRWRH?=
 =?utf-8?B?VGFma0loK2M2dURuaTlDSkxuWkxCOXN3cEh1Q2RJd0wrUTF4UytJT2Q1czFS?=
 =?utf-8?B?OUp4OUs2aTFGOG1WeTB3MEwySHNWTU9SSjRnUFpXVjcrVmdCOUNxS0ovVThJ?=
 =?utf-8?B?LzdKUFpOVEJGdFhFbjJTcmhQbTVsOE5rSE94NmhLb3RuNXp3Y2swUzM3bUdS?=
 =?utf-8?B?WjcwNGpmdTRyY0VzK0ZoUlpydXpWdzRvcEExYWZVVXh6bE83akJwN20xNmFm?=
 =?utf-8?B?UFBtQjh2ZUFYS0xCV1Q1T0RSRWpvMVFQbGZEeDJHbjFvRlI3Z3FSTFBzWkcw?=
 =?utf-8?B?QkZrbmd5ZWpWbFVQR3lEaXI0Zkp6ZFh6SXZzbHlzK2phK3FVUDc0UW5BMW1B?=
 =?utf-8?B?aWlsZVF0WmNlcm95RWo1T0JLSWNiN0RudTJSY3lOUTJmR2E0Yk1lSnNjNlFK?=
 =?utf-8?B?U2tOdWlFZU1FV0U5ZUhhV2dpU05tanEzalc2R2VnLy85eEpDMDRrb29NU3d1?=
 =?utf-8?B?VVJsampialdMdmJPbE4wTmhCYWIzbUd4UG5GYm1wNEFid2M3VHJFUTcxeXlr?=
 =?utf-8?B?YnNFSXVvZW4vUjZPNXNMUVFSbHpTbi9JZzdRT0t1NFJjaG4raFFJdkh2Y3I3?=
 =?utf-8?B?SUI3REJ6Z0tlcStVYXlqVXRrbkhINnhSWkR2MzE2RDFRd1VVT1JrdVg1TXo5?=
 =?utf-8?B?NUdPeGlFUlNybFIzbTd1WkdWWGtkTUNmRnM0V05vU2h5cU4xa21wRkIxOWhr?=
 =?utf-8?B?N2lMak1kazVHd290N2xMeGZldEJyK045R3VEZ0dRTTNBNTRDZitHbTA2YW02?=
 =?utf-8?B?UlJjVVc5d1F0VEZlNEl4QzFRSGhhZGdJdGVvZ2dCWm9KamFGNnFJRVRHek1j?=
 =?utf-8?B?TGRkNXg0ZDBEVGpYbjhuMkRrTzViaUNLM3RGUHRWeUtoeVo5dVR3Mkd3Nndw?=
 =?utf-8?B?S3ZQZktPY0MxQ1QxNGF1NFA2c2xTRzNaZWJlRkJJTnVNcVpiR3BTVklxQ3Fj?=
 =?utf-8?B?RlJPSG13QmVNTkhsbC9QUEhud0lUdjdIcTJ5MGF1ajExSks3TFRuamNZNjQ0?=
 =?utf-8?B?bEpCNkhSMW5DTXRnc2pyc0hhMVVOcDhRUEZscnlsT1NVTWExM2pmNG5NRkZO?=
 =?utf-8?B?UFF4R0NzbURSNVBTTXhhRWo4bE8yeU5wYU9ka3h5c2hNM0VhRjE1OElWd0pn?=
 =?utf-8?B?bS9aekU5WGtWVjBXNWIwTXhQWVBzYWNhYzlLSnE4QUI5RHp0WUZCamF2NDNk?=
 =?utf-8?B?clNaV1d2TkNlS1BPb3FzeXR3aFRZZnh4Vkp2ZXZYZ1l5U2crQzBQTTRrMXlT?=
 =?utf-8?B?ZW42WjNvUmN0WWg1T1dEeVZRTDdkMk1XUnZyaWkzaGJoU2FhMjBPYWFuTm96?=
 =?utf-8?B?T2RaOFFHVldHTnNETk0yUmNPVlpEWWNQc3p6cmsrUjU4Q1hBWHpZa1VRa1ZG?=
 =?utf-8?B?dHZWSHR4ZlJkNWdiVkhHZjZsaTIwS0NOR2RaOHNMNmRqdlk5c3dyekFkenpm?=
 =?utf-8?B?V0ZaQXNlb0NGWlUrYmY0cGZrUFBsZkJ3Zi9NbnBUaVgyV3RodG1YSGJ5NW5C?=
 =?utf-8?B?WWVYWUdYK0VvK0pUbFdjS3hLWmhiRTdnSzREeUN2OHFMWTNWYVptYVFLNytK?=
 =?utf-8?B?bFhUTkd2cGlyM1FNWWd1RkJGVW5LRTFaMi90RDFKZmd4Zmw0NlJ1cDVNUjFW?=
 =?utf-8?Q?ji9zB9RnC1NPT0EA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F791914580BCF4A86E6AA34BFDD9300@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: enmGOd8E7j2Meorc26I1+Mos3zGRRfpvDWDHss3KAis+YW8BkuMhFNgTEdEvidC8eqeMGhLvOaORpKCUpEZEkm/P+liZFnBUFp9SB540cJOPzzJU6QR1gBN1sKPYqL9YsuEb2yK+zmXkVKnI6NyNCKcEOflkSE1FiJANuGNe7mRkPpMXiLRvHXUwafKiPavhomntq2Sc/a+B7+QJAMWOPXRD87MjGjIpv5MwLE4dwNkCKw/DeSO7N1r4zPQx26vsTFLlM6fEL1SVRL5y1POVHBWoZ3elPxquiCbFgUnCrQr+1GKQtMXzcTdW6i8BN//8ZejXObXtZdPclhf6K1adOw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0155a902-b56a-4d76-4f6a-08de86a8ef99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 17:48:46.5372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LN182iLfoqllck2xAWr/NLqY5u3jQeeYtISwT9jthyaCyoTblS/VSwcvhtUnyocMQYwox9bilFPbLc5BgRXxuvhyMCPNynbUmn9HkVXCp4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8525
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTAzLTIwIGF0IDEwOjM4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
Q2FuIHdlIGFkZCBzb21ldGhpbmcgdGhhdCB3aWxsIEJVR19PTigpIG9yIGZhaWwgdG8gY29tcGls
ZSB3aGVuIHRoZSBodWdlDQo+IHBhZ2Ugc3VwcG9ydCBjb21lcyBhcm91bmQ/DQo+IA0KPiBJJ2Qg
bXVjaCByYXRoZXIgaGF2ZToNCj4gDQo+IAlCVUdfT04obGV2ZWwgIT0gUEdfTEVWRUxfNEspOw0K
PiAJdGR4X2NsZmx1c2hfcGZuKHBmbik7DQo+IA0KPiBUaGF0IGdvIGltcGxlbWVudGluZyBhIGxl
dmVsIGFyZ3VtZW50IHRvIHRkeF9jbGZsdXNoX3BmbigpIG5vdy4gVGhlbg0KPiBub2JvZHkgaGFz
IHRvIHJlbWVtYmVyLiBUaGUgbGlzdCB0byByZW1lbWJlciBpcyBpbiB0aGUgY29kZS4NCg0KSSBs
aWtlIGl0LCBidXQgSSdtIGFmcmFpZCB0byBhZGQgQlVHX09OKClzLiBDb3VsZCB3ZSBkbyBhIFdB
Uk4gaW5zdGVhZD8NCg0KRXNwZWNpYWxseSBzaW5jZS4uLiB0aGUgcmlkaWN1bG91cyB0aGluZyBh
Ym91dCB0aGlzIGlzIHRoYXQgdGhlIGNsZmx1c2ggaXMgb25seQ0KbmVlZGVkIGlmIENMRkxVU0hf
QkVGT1JFX0FMTE9DIGlzIHNldCBpbiB0aGUgdGR4IG1ldGFkYXRhLCB3aGljaCB3ZSBoYXZlIHll
dCB0bw0Kc2VlIGluIGFueSBtb2R1bGVzLiBUaGUgc3BlYyBpcyBhcHBhcmVudGx5IHRvIGdpdmUg
VERYIG1vZHVsZSBmbGV4aWJpbGl0eSBmb3INCnRoZSBmdXR1cmUuDQoNCkluIHRoZSBiYXNlIHNl
cmllcyB3ZSBkZWJhdGVkIGp1c3QgaWdub3JpbmcgaXQsIGJ1dMKgYXQgdGhlIHRpbWUgaXQgd2Fz
IHNpbXBsZXINCnRvIGp1c3QgYWx3YXlzIGZsdXNoLiBTbyBpZiBDTEZMVVNIX0JFRk9SRV9BTExP
QyBuZXZlciBjb21lcyBhbG9uZywgaXQgaXMNCnBvc3NpYmxlIHRoZSBmdW5jdGlvbiB3aWxsIG5l
dmVyIGRvIGFueSB1c2VmdWwgd29yayBpbiBpdHMgbGlmZS4gVG91Z2ggY2FzZSBmb3INCmEgQlVH
X09OKCkuDQo=
