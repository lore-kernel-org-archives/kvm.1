Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D33EDAD1;
	Tue, 14 Apr 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188471; cv=fail; b=FDkKoiZSszbuLenl8CzEEQmXL2wFPzBshVPCBLhDIsaxl9bKIWcCQ5nNXxd+n8RPkf7j6tRfocQlQvmd9CbYQu1ido7Yq5zsoqoQiZq0pSTcDd+qX6GTD5V90A88p+QvS6mRN/wuogckDRKVeaHiGUbm8KByH1S2tRAvlyzjIyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188471; c=relaxed/simple;
	bh=fyv3QAAiasS7ZLmizIzfiFwCuDC2BB9quDEy/o2ip4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fgc1xKZWdeB0beYqBRVRa0G0XgfvvHmkRtdtssJgvT4+uaw5hSRTKq78XtatCnsVlurVo34My75Riwy608EGUhPkbmpYzZ4+3OuA+cw+PQvFyfz8qCmJ+UZ/WcCgnDiiNelFtUGcvG7XMuzxZaNeoc6dcP4JUivy+kVau5fPm9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWZ0dg45; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWZ0dg45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776188471; x=1807724471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fyv3QAAiasS7ZLmizIzfiFwCuDC2BB9quDEy/o2ip4Q=;
  b=cWZ0dg45rbFckagnB2uRZa2Dhown5UU/Obf6X23qU38gUT5ZLiVijcR7
   IAph/xEwyAZs9gWU1KU8Ct3vuxJmGURWT4XMnVGkbq/UvYfm2R/CvVBbD
   ALLBXwlsoJm5zAJzNYOMrcKZPpUaKeXFq3zG3FKQEewz2IvxafosNlMDv
   jJcZT4HH6hSpiRzis5N/XRZ9VMGwdUK6FCOcNVQ3ib4IM1lt6MMGxe5On
   XejHbPCzBnCPKKcwVx1jdmEBMSsIasYvFndA6W22StP0Y6k7CKgGguFYQ
   K5HzYYrpmrIFHnYdIsVv9VUgKIaSo8lt20EsH7y8TOp0YQ8k6dbwiyfg2
   g==;
X-CSE-ConnectionGUID: LWzVFBB5QIec8bmNIBBugQ==
X-CSE-MsgGUID: EPegjT77Qxq1rTfwLgrXJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87461069"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87461069"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:41:11 -0700
X-CSE-ConnectionGUID: Uo1+eBvDTJa0QvVTisL5vg==
X-CSE-MsgGUID: qouP34GHTnWonupxn0p2Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235098880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:41:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:41:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:41:09 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmKrnX/ptiQT+thxbX/K8g8PS8FKGjkVJmrnO2UmLTuUzJOPWdwgJZpmnBUXALL0eFxpbpa4T3lQsAgw6oDiLSYP0kaiN6DCgOXr387rBgG6C3V6tilWIUTs8a4UCkUasgW+8HXisjZvnAu4Mg/DpN8fC1ao68jVs8UF0cd17eEhXiHYfzDpbFFmH6bMK6oBIGPgiN0jC2ZUonkSXta7xW83UJhpAXUh3Use7sM/PCqEw/DN9MD5y8zKShi2CYkmEkU47HyMTgoiBq7tPdxOVKz++8/Tcx4PQGbDxnuojA6nWObTqQrSQFeoZSn03c5t4InfOgW3S90WSi1iLF+Ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyv3QAAiasS7ZLmizIzfiFwCuDC2BB9quDEy/o2ip4Q=;
 b=A2t9+HcXYvsPW0ZpHMowDlrUJTJAmJ8fVd6wvI8p4RQNjT0Bv1YpTF13p5nCn31wMrejFoG4qQrxlUytMVbZostMeUYO7B5NgOJSa+//JkpeBavHCNtbLLEfZGoOTpFNfIY3RW8a+ssFyGegXZIfOe/KRwXbfFX18K+dszt7SWmhmF/Y4MYtQdvgcvaa1dqFM+Az83Cjly1giW+xi1uh4Oh3q2sVicF/c5sCnFiqf50thSQBZ6BWV0XBDn1D1VRQuKQw6qPFqnP+o+jvUy7o+fvfbpT5SM2QdHxbeLW8M/9Jj+1rnC9dml2IMZuuKhErLHQUVnXwfVBvySogLg+S2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 17:41:06 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 17:41:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Chatre,
 Reinette" <reinette.chatre@intel.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Annapurve, Vishal" <vannapurve@google.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "sagis@google.com" <sagis@google.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "tglx@kernel.org"
	<tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Topic: [PATCH v7 10/22] x86/virt/seamldr: Abort updates if errors
 occurred midway
Thread-Index: AQHcwQv/Ma1z1LjCBUm2ZgQgcKxBmrXZInqAgAVGIwCAAIEHgA==
Date: Tue, 14 Apr 2026 17:41:06 +0000
Message-ID: <80a01d40855136a5825e5f353a8cc2982dde385a.camel@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
	 <20260331124214.117808-11-chao.gao@intel.com>
	 <fb472138f6ba06efd90a3834a5748662d7b7ac44.camel@intel.com>
	 <ad4P9HZEOnC3wUH3@intel.com>
In-Reply-To: <ad4P9HZEOnC3wUH3@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5299:EE_
x-ms-office365-filtering-correlation-id: 244c1d0d-ad4e-4809-42c1-08de9a4d0196
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: bJVqH7T1EhmRflXe9rSbCYWZiPS86X89i8Pfm2cTNySG+EUWhLpe8uWljCjNpOep9Bt8lUPYofDjkQdggKdco2hzD5Bc5IA9b2+NRBX6uZ9ZkC7T0qiFwJkdQr8snjsrAM7ipSHJ3R6GL1LL9PFeOO9n6UaO0L8mVW2vIXo3SI8WRd74ynAQtwJE6HSnvN7GpKw+9nnspkIzNfRNYUJ1UQlkVjn5mKlydMcvvKWV+dfdDfjKjnRwK3i8TPLBgX9Gu4m8QywQ4LytpVgP++tSP5uUb6yJOvGfR5nWXfkMQY9azUJ0QfWd3AIF2ndyAJTzmiAlJ47FLH5C5bKkCXQCKVFsoD6dza9iC57OnX4nSVkz3vGIhOgBMONyfNuCupl2mxuwl8psPPuPD6ZVex/GSdB/l5Sn4q992f9G+Pg4Nc0VLuUA+okXUrObO3AgYzvbYtgf6PyK+CuWlPKlBrOOuYSsPp3M6FuAqpLm6YqB/BG/h2eCpn9DaDD9ArUP9I97XyVtYEt9GmuTeI+LAjyaucOlIzBeR9IhjEWF0tFHznVlV/XlS15IuWXFkpMmm+5nwpt6opNhlLv0OZGfPg639/mfWEKyIZclNH7YQv3NzZuWFx5nDjMYoeTyI1P8oXmo40ofOA+6hsLzfIkNQUf49q1Ak3ZqU1h1qUP8fNHSMP+kI4AWVxvHrgz4NIlb2Q6fagUdVCzNLh67kKIJH8pf4tMGhL8vWLci2tT9Kc18L2/wzOIcEMINtL/3McBR64VHOEJPx2iQO7EyOOYt0QaZPMMQy9rhIplerG16KmbRKSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk5xamdKS2c3ZDJMWk0wdythbllmVmhKeGZvT3hJQzBWWDQvOXZva1pldVFT?=
 =?utf-8?B?eW5Nd3NCSFg3UklwdzJXenFnb09BbmNSY0paK1M3VVV1TS9kOUE3NGxFOUNk?=
 =?utf-8?B?YzNNSGVWNkF5ZUpPS2RUc1dUbWlXSWovN2VtYjFjR013UzZaN0llcFN2MEpx?=
 =?utf-8?B?M282WmgxTDE5YkI2RHdMbWFpMkJBSVBQUTVQRWsrU3ZDSVJNbnNHT2JxRG9t?=
 =?utf-8?B?ZGRSUC85L1UrOUovVnZqbnNKUXlaT01zVWxsbHdXY2FyQlAwcjBENW1wL3Vw?=
 =?utf-8?B?QzY4c0ZaNWFyTUhoSjVyZTAwdjRFeDA4Q1RVdUp2T08wamtjQnhISVRCcm1w?=
 =?utf-8?B?ZitvR2NCb1pCdUVhQm9CYS9Lb0xpNW5OTDB3bmtuTlpOZXhrYlBvc2FxMCtX?=
 =?utf-8?B?c3kvYjJiTE9razdzNE9aMUZ6SCtITUFlVlBpSy9ZbUtVRjQvMkZ5ZVVheXE5?=
 =?utf-8?B?NFBkZEpGRHNrSTY1NEl0RTZIdHVweEFNOE9VcTVLMHB1bzRLZm9zNHJBK2Vy?=
 =?utf-8?B?MTFlcFYzVUpxdkhZNkJVeUx6VS94Z1l6dFRYVHdkekZkRWxSREt2TWZhRllK?=
 =?utf-8?B?Ujl5NFFIaDhxaHdNL1pybjYwMVM3Y3N4N2lsVVZSMWoxcW9nc0cwVi9keHZO?=
 =?utf-8?B?QVdjK1hxaUZpaVJ0NlBkR1VDRndReG8zQ3dtZ2N3aUJaK3Blc3hkME8xRkx2?=
 =?utf-8?B?K2hwMWV1aXhySVYwTnFVazlTMW0yVi9GZ3dGaTNWSXBTdWU1K0syN0QvbVYx?=
 =?utf-8?B?L1YrKzZYMVpSOFdZamJiUktUOEF3ZEpjKzQ1THpOK1R4V2p0OXZqTXRtRmR2?=
 =?utf-8?B?QkhXazJ0L1ZwMFBMVVE0VDRyWHlWV3ExdENjUEhPaFAyQk1oWTJ6dlRqYzN3?=
 =?utf-8?B?QlJwUW9LOG1kajVSM1hoUGVmQmUzdDRlaWhuM3ZpMFJ5RFdXUFhobjRGQUhS?=
 =?utf-8?B?S0M1WUN1ODBsZUFrNXk0TTBNM1FPRWIzdm51OEdhZFE1ODd2aDBPMmk0OFIv?=
 =?utf-8?B?SFB3M09KSVp5c0NuVzlaMHB4UTZ6c09XTUs3SUhuRGg4SXhtdml2NGpTYUgw?=
 =?utf-8?B?NWt5Q2pYY0liRjNHM3haeGwrMlcrSlpEUXJqd0JUclpLSDZwMkYzQms5Y1p1?=
 =?utf-8?B?dWUraXhxbjRmZURQUjdpNk9vbVRRTTkrUXNSNlJ2WFJtTzErWkdtaU4vbE1h?=
 =?utf-8?B?ajRNNmR0V0hJK1VWNzZTbDZZUWlRd0FSTXl1ZFNndkE1cTlWRHNmd2RDcGMr?=
 =?utf-8?B?bElRNENJUWMwNW5JeHlhUHhYSzhzQXNnWDNLcDY5M2VzckF3UkMrczFrRGdH?=
 =?utf-8?B?YlUrMFhRV2hkOXlmUDJ0blpMWjJtS1VQV1NsM0NKQmpGbG5kd3lSb3FFNHo0?=
 =?utf-8?B?clFtZzhxWlhkNERCUFNJNUVla3lhN0xIY3ozRmVsR0dzSGgyNmVVWVZXQmVK?=
 =?utf-8?B?b3o0NmllUlUxdm1ST1ZuTnVZVzVwVFFhOXBOUHAwT0l5eWxHemZyclR0aWto?=
 =?utf-8?B?Szh4UlF2Z3VtMHQ4TUdQa1I5U2RUUU12NXlXWGYwcW0wMW5RTzNpWTE0cGdu?=
 =?utf-8?B?N1V4aHVMRE5rOHlkQXJ0OFU3ZFZ1SGp2L1NjWjNqVnc3U0o4WWpRdWxhTzVi?=
 =?utf-8?B?aVZBbGsySWd0djR0OFVmWHB3UGRTdHBVUm9vakJkeW5YTVN1OVRMS0NXd0tO?=
 =?utf-8?B?VWt6Um5vR3VkTnpCd2JyNFB1b1ZLQkFCRTllcGhITWZqc21rczBScUZXeG96?=
 =?utf-8?B?WkliaVNkMmI2TVh6Z2dueithcmhmRW5jV3lDQytuYkRuT1N4elVzWHlIdXhR?=
 =?utf-8?B?alFkRWJXVDFSVloyak1UcSttMk5nbFdYMlFYWDB3VTM3MThLUDZjbncvN0tu?=
 =?utf-8?B?UGlxNmI5dy9obFJKY2F3cXBTUGZjL0hGK1pNeUFLbytNUjBXclBTdE1KeGRU?=
 =?utf-8?B?T0RqMW8vSTJhSkI5VUhTZ3RIcnArMERvMDlIbWszblFMU0xPWlFHU2NMR3dG?=
 =?utf-8?B?QmZxdG5LTEZGdWlzdFZDZzA5T2hrNUhkTktxM2dVWXJqRThoVU9LVnJ6R3pq?=
 =?utf-8?B?ckZZczlXeG5MdUhrdDg1eWJDeTRTRExhWjlwdWN5ZHhWbHFaaWhnMkFJL21u?=
 =?utf-8?B?dFFZMEh3NDZOS1daZXovTXZrMnQrM3EyVzFKL3g2Tm5nQjNITVNCcHBZcTQx?=
 =?utf-8?B?L0JGRDNSVFlaOHI5eGlQVWx1ZnI5d3dERUlieVVlYktzVmc1K1lrT2VsS0Js?=
 =?utf-8?B?eG8wWS93ZkFCRk1IS3I5bVFOK3NOSXNiZHU5bGoyL3FoT1Z4aDd2bXJnL3JF?=
 =?utf-8?B?d1hNTzJ5RkxoSTNwWkxzdHZyeWJGWWtTeUpQZitOMDNrTVNTam9FaGJEZ2NG?=
 =?utf-8?Q?0uv4RagbpweHJMGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DB46889A610C84C87F550F7C36F8DD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O0OIkQIELEY5yHxEbfdUV3KMjaC9UxFov3jPEiwlVWFwz3wDgtlniDdXsLEsIWfDQ5MOvfLo1U/tabt6mMcm35Xn07QUEae57qBG60nw5vqQQdli8SWclUfXUZf5BIPKbBdhiJilfOGxfmDTTrGq3LmfLN6U/3GsYzfXHRSgQ6m0FIlkPM7VSCEtDo0hwtQLGHCPHo+qmt9OjNRGgxBSn9LoX3wYfyKaWtyQeH88eWTPFil5Ha/5oB91QQASQfk59JhtihO5Lft2DA/UpfnLE0qUpe5uOT4TAfQ5Xjj/M9MAUQF+Ve3dr+eISscfrmq39+ox4qbgmvL6nzZvR/NZAw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244c1d0d-ad4e-4809-42c1-08de9a4d0196
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 17:41:06.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59nq9ORwkBqhR6k82RgaEENCHvXmiD1pv/bHCvsAVR8dCQTPGBbwckFdJgX5XEVKtI4RKtM5wslvBsr4ux4zdl2v2XSVFbTf9+GSaTQWFyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTE0IGF0IDE3OjU5ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gVGhl
IG1haW4gcG9pbnQgaXMgY29ycmVjdG5lc3MsIG5vdCBzYXZpbmcgdGltZS4NCj4gDQo+IElmIHNo
dXRkb3duIGZhaWxzIG1pZHdheSwgdGhlIHVwZGF0ZSBpcyBzdGlsbCByZWNvdmVyYWJsZSDigJQg
VERzIGNhbiBjb250aW51ZQ0KPiBydW5uaW5nLiBCdXQgaWYgd2UgcHJvY2VlZCB0byBzZWFtbGRy
Lmluc3RhbGwgYW55d2F5LCBpdCBiZWNvbWVzIGRlc3RydWN0aXZlLg0KPiBBYm9ydGluZyBlYXJs
eSBvbiBzaHV0ZG93biBmYWlsdXJlIHByZXNlcnZlcyByZWNvdmVyYWJpbGl0eSAodGhpcyBpcyBu
ZWVkZWQgdG8NCj4gaGFuZGxlIHJhY2VzIGJldHdlZW4gdXBkYXRlcyBhbmQgVEQgYnVpbGQvbWln
cmF0aW9uKS4NCj4gDQo+IElmIHNlYW1sZHIuaW5zdGFsbCBpdHNlbGYgZmFpbHMsIGl0J3MgYWxy
ZWFkeSBkZXN0cnVjdGl2ZSwgc28gYWJvcnRpbmcgZWFybHkNCj4gdGhlcmUganVzdCBzYXZlcyB0
aW1lLiBCdXQgdXNpbmcgdGhlIHNhbWUgYWJvcnQgbWVjaGFuaXNtIGZvciBib3RoIGtlZXBzIHRo
ZQ0KPiBlcnJvciBoYW5kbGluZyB1bmlmb3JtLg0KDQpJZiBpdCdzIG5vbi1yZXF1aXJlZCBmb3Ig
InR1cm5pbmcgdGhlIGxpZ2h0cyBvbiIgaXQgc2VlbXMgYWxpZ25lZCB3aXRoIERhdmUncw0Kc3Vn
Z2VzdGlvbiB5b3UgaGlnaGxpZ2h0ZWQgdG8gZHJvcCBpdCBmcm9tIHRoZSBzZXJpZXMuDQo=
