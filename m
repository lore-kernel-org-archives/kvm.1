Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD4138E8D8;
	Mon,  8 Jun 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914671; cv=fail; b=MH9HbNbB0LAUYlVWRP0oS+M4SBgfNnb1QEkbe2yESUNXbJpnLDf6bSLK/3xLVGHuNNleNbwV+UWuR8bRq1qFATVW8ogcBfcakS210ZEDBHHRadhEoJe829i3VlXecWTvsc3CplOyboOVwZ/mmVl5TiYty4xY4xqH2WqNaf/LpoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914671; c=relaxed/simple;
	bh=meqZeJF+x/jOzV9hwQpeh0o9hjDAfYiTUzn3/vYqY9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWlCGxsfCugaUiVhiaM6gTRERJFyX1a1QUjjVhtKXtZEErjUuKhLLFWbCyFRYIxw5pkYb+RQTSGnVOJB8Qf4ZN2QNeCF+rbQiD0Z+KzLZ5l14tQJIZ2/zxaoT1YF3Nt2U5m1cJR7ItGbvAO2YqCe7osqKFo8h9ZqLzHpzZf8A3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lN94dBjG; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lN94dBjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780914670; x=1812450670;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=meqZeJF+x/jOzV9hwQpeh0o9hjDAfYiTUzn3/vYqY9A=;
  b=lN94dBjGKQzU9wUd5y6Yk+Mg1liVNexc+ulPrfNwublpiJSBmk6TvWBS
   yZILfTtYwjlp/wGzMnd/E96uOJGvzYgOA8vGwlGuMzM2968aiTGUX7MHw
   yAR1QsikGb5MLtz3MC3eLUshEcxta8sMqZvLKnNv7O0D4w3/iIb3968oa
   9Wl0aP2q+IerrfxIcixgnfcwn5QJipST2ABfmgEztUjUY1yrjwViHrDOK
   f35dkdOzXCGL4AaIcpdCLZD8oNWqGw+BeEcQ5yAHqvZn3UBYPcfwRyRgB
   YnR7iSJ9wNiweP06SgiqbLwmDO1zMeUW0RJ+SzspRqdE6zewz33eTvRxn
   Q==;
X-CSE-ConnectionGUID: qhUal+QER4qEQo4PGOZBNQ==
X-CSE-MsgGUID: uKOBCY6gSdSVgXkSylL5rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85499751"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="85499751"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 03:31:09 -0700
X-CSE-ConnectionGUID: D4bJcTcsT8ODFzSF2r/BJw==
X-CSE-MsgGUID: SzgZlmMNRsWLuYkA0GgiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="283595432"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 03:31:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 03:31:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 03:31:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 03:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qnbs9Nqk6xCiYX69cNnd/V1JDJp6fW9lFcIDul67jDUNOtqTUrmle3puz/q6Phj30+Wwm1cpY1R4lOTggsiU2Q6Iuu84IcAswFpKWzmQPSwOuWJMSq+K0aRIL3EvyQEbxZnFLajweLw7stQ0iJy8h42olTnb7OwEgj7muLzMVrWFIQBwiNANpSk4ch3UslH+lc71klpTajZJ9MtuGHsNTXCI0oU4MLpMQt5dxEY7R922ApfX6vx/SCaPHIXg5MMiQ5jHHezy6NswIqlFhFl09bFZLZH7/xvEw8BmKGilFKbho5m2XywS+x+SGyqh65/CtECebA/0p/gDIgku9KGcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9746NdmS/fmGrZ9rrYDfOhGfqHm3PxTQdQul6tbickA=;
 b=aH0QyrBsxadXGiRE32v7RuvmJDwGIrJPtZJ23YL37t1lSge+KP/sxbC4kMHrbZ9ZJXnYnEHKFW3soulUNWVGD9IDrOVmaPPXoDVcDcxGw6ARWIUqVSjEq0kdBCa0oWgkmZ5MKSNcrwzGivgRj+jdixw8uGJt++KESAQk4tq1n7HHa7QPXfKk8SfU5JVhO9rLzGhHJ/+yLjOfIajapgxrADcEmZloRrWJq3CaX82YUv5grfuGCkTjDD2TVhRtIQJTuruaYVV9yOTReoatxzaYbQ9GMoxBXSEvr0cpYBJ27hO+4SZzc/vE+wIaJwkrBMdQGP6zxIWzFCQm+NkfyIcs9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 10:31:04 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0071.014; Mon, 8 Jun 2026
 10:31:04 +0000
Date: Mon, 8 Jun 2026 17:50:32 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Kiryl Shutsemau <kas@kernel.org>, Chao Gao <chao.gao@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Message-ID: <aiaQaCzL8o2yLu/2@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
 <aiGq7XjmMrsqdBY5@thinkstation>
 <aiJhScChLZkH44eB@intel.com>
 <aiK1_q8beMcIEiwO@thinkstation>
 <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|LV2PR11MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 68940ceb-2f7e-4fa3-5a38-08dec5490ad4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: l+r8i8rJSl3hwReDQa/TYihc+5BJS41SxFCLd9eGJ2F4Jqsh5I2vDtnDOPDdvLlwYGNfvIajNK98Vc74GZz7pzoY0X2yIldpLEVX8mBee2H5U2Z/oP1DK5gNu2RlHzBSwEyQZ8k2vf4UKbpb0steL9t18eCncU+YYWDkIyS0iG/ty/z4kqS1i4Xi5q//frWe+jwm2o/AYgu2crdJrBd8e0ZjTu+K23NzhuGi3dFxtwFoZXVlWoh1hi/BTSIlzQke829Q/Wq26I/oRlxfBmQav9EqQ3i7yi0Ktv1C59XyRxH+8UMcjfuq3quKe7Kq3Dbs0cuKWdEzji5yOa4T4zUUGLUjp46ACNMYiG6lc12RuxPbTRnUX/vonlCdcyBl2y3m8aBBh1aYEZwvrZAaXqxJxlgdLWqQdU9joKa8CN/P/ReYAPrbXb0XFYEn3XfWQbj5CW3w6nyBswSup0kEf6Aw4RhQlElNVMDLDoVJ8qKERh3yyr69l0FgQamrQ3IipHCF2LlkouAj+nUGyUzxjnuo5FnDlBovtITbJ7011kdj/4HunXHkIv32J3jn24gkdy25UjmB/nRpASheeaPKVmHVpc+a4oHKqg6A8HBdXt9jRpgRWPT204LVlE5fTo0fhS6Wv5MQp55TalfPqiegiI7JrmUT5Bbka7nPnw8PYq8feHmrzvnm4WUBATg5pPlfzHDn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTB2U0xNTklTK25oTzlSUFZaZjNkVElsTXMzdXc1ZHg4WERiYkFKRDMvTkNK?=
 =?utf-8?B?V3FVOHgrMFJuWG9zYitoakU0VnFrVVhlY3hIRCtDRVdIMFBpRjQ5bFd0bFEx?=
 =?utf-8?B?VDg2dXlrSVhucStNOHcxOGVsZDkySU5sRkNCVm93TGJOSVFBbGt1WjhMQ2N3?=
 =?utf-8?B?QXFxT2tBMVJSdTRCbnZmTHBub2U0NGF3aUlCeXpXY1FBeHdxMHNDU29kSmtQ?=
 =?utf-8?B?QWxwOUNDbXVQOS9vVE9ES1d1L0N5RERxVCtMYXpjUVd4Si82bnFucldNK3lz?=
 =?utf-8?B?WC9wcGRMQVhIWUYxNmdDVmFYSkRaVTZYanVHdXBUcTJnR2h3V25BWkRHMzdP?=
 =?utf-8?B?ekdJZVZaV3JxY2gxUktPSXVsRElVVzlJcjhJaGpnMy9wcHNBdFhoRE1pNWps?=
 =?utf-8?B?NFIrZFpHdkxwdVA0OE1KOEpqVVlDU0pNU1pVUVk5VGNhQWllNjYvVEhFRUdP?=
 =?utf-8?B?RFJoYUNlbzBPaU00dXJnWGI4dlhJakcyelNBdS9jQ0tNbnhOYjZ3M1luRVJB?=
 =?utf-8?B?RFM5cExuYzQrQ1gxU1pDQ2JlcXdGWmg2cURCenI3WUtTUlFDdHN3QjlmQWJ2?=
 =?utf-8?B?WEJKZkwxeFcrMGl6TGNHMTk5ZUtOYlhyOGI5V1dqY25ZeHVwMUg1UWJBTGl1?=
 =?utf-8?B?cldEVHJXS29DMWhEdU5zODRTb1lRcEtYOHMxZHpMY25qSjV5QWN5QzJwMGpO?=
 =?utf-8?B?bXRZTDlDV0ViNS9XS3Njem5zbXVhZ1dBOXd2eWgvQXRtNTY3RW1IdUJIbFdm?=
 =?utf-8?B?aVE1ZVBJU3J2S3ZqcjMwOGtIdExzRWxZRERsTGpFeEdpR3dBYVRPang1ZjVV?=
 =?utf-8?B?aEEzRW5HTmVjVGxRK1l2T0hONGVXalJaTU1FU3Evb3psbnA5eXdhYW01bkFF?=
 =?utf-8?B?T2NHQUs4WUcycG9kQjVJdXhSM1BLOExxV2J6SEJkTWV5VzZkRDJmVWVwdFEx?=
 =?utf-8?B?eWpyajVtN1ZiRXZXc0M5OTFhNzRJUDYvcE9YcDhJQmF5cUdpUFJadEFCMmdi?=
 =?utf-8?B?bXhxQW1KMFhJVmw3QlpMZzdvUW51VnMxN2VUbGx0eTJ1QkNvc1orMHVaSXJ0?=
 =?utf-8?B?bkFYeUdJZTBLVGdycE9PaXozaXRtY2pqUVgyOWgzZjd6bVkzOEpMZE9lQlVp?=
 =?utf-8?B?K0dEaTR5Y2JaOGZuMG5rYmNTeWJ1eHNZZjA1Y2V1MlJUdkFxNStEV1NIeEl4?=
 =?utf-8?B?a1JEbVh4Vm52aVhBRFN3eDFldG9xOHFGMVhuOXQ5S2tKNTQ2bkIvUCtxL2pJ?=
 =?utf-8?B?aWpwOG9pdEc4OTFZWUVoRy8wVTdmSysxSWh2RHVhM2Ezelkwem5VNGRCWlpX?=
 =?utf-8?B?ODJBbTVUc1FMSXBNWDZlWDltM1h3RzBCYU1pTnhQQ1dGNEU3cWM4RnNuTk1T?=
 =?utf-8?B?RlNzbmw1V0Z5a0RpVjlOMThCRE5TSm9EUUhiZXpvTFFBbm14OWJwYW10by9y?=
 =?utf-8?B?eHY2TzBTbFBuOHBpM3VsRUFwZkdnc0tXbzhLWE13WXlVQXRxQzJuUDk2bWVw?=
 =?utf-8?B?MVRUSmhWbnhzVVZtVGZlakhYeVdqdld6RXFDNHRlRFVKbWRYbGs1TzJvV3dl?=
 =?utf-8?B?Sk1qek9FQVlYaGdoVEVNVkEvQ2dTUWwyMnNGTkRnRWFDcWdhVmZ4S3p2UjQz?=
 =?utf-8?B?NTRrUW1NRW9SRVlmT2xLRjd5dVpnTHpLWmJGTXdpK3JzNWlvSW9MNGhNZHJ0?=
 =?utf-8?B?UkpzQnYrRmxTeWx4NUNSN29CdjlBZlIyUG5sVHlsVmFsa0tDK2VGYklRVU42?=
 =?utf-8?B?S1VSeUpPaXlMYlFHaUl1NU9mZFozaVM4WkZGcHhTMnNGQlJtZGx2S1VwL0hu?=
 =?utf-8?B?MnRXZ2VCcGFITzc2bGJOc2tLUWlaNkhkWUxWc3pZWGJGMVV1eHFtZ0t6eTlD?=
 =?utf-8?B?VE56V3ZLNFAybDZCRGRuSUdiUFJBWjBlRXJ5UzViMFUyYm80d1lid3Q4aXAv?=
 =?utf-8?B?cUJwQ2Y0b3p1dmRCczJyOWJMWUkvSUNSZWRoUjgrNTlCOFRFWjlQUWNRRkFo?=
 =?utf-8?B?WHhJaWlvU2FmNmVINk9rYzBwdnhDV05XQ1FmWEVVMm0zbGlPYU45dWZhWVps?=
 =?utf-8?B?NmNmbDFjRDhkc2hIS1h3SDgvc3RmWWhFOHhuRlJha2lVeG13SjFXWThFWUtD?=
 =?utf-8?B?K2ZreEVCZGZzZGNGV1hsSWZWZlBYM3M3cFo5Q1pDa0ErM2xCQUZxNjVlNE9I?=
 =?utf-8?B?OFVQdGgxU3ovNnN5emluNGlaUm5YckJCajBKdDZtZ2hIa05RdTY1NTZkV0E2?=
 =?utf-8?B?a282czY4M3liSEt5ZEQycXIxUGNEa21EYUZPTUFoc1JYRTFOWTVWK0k1MmJl?=
 =?utf-8?B?OU5jR2xIQmoraHhjenNPR0VxMWZHNHI1bkwvcmI0MEw4VkJkVDgwUT09?=
X-Exchange-RoutingPolicyChecked: EfHffFKT4yJO7JM47vxnOTT1RF2zOsWYqAcLJEaamhehD8pTJR635OdqUSrqrXKwuajsBOoy2KCbAOZg/zIj5b1ErwZDmdzkYnN/g4c5McPqNQyNMzhUw/1UNsjJBq+p+tH4IqCVB2g8iIecRhwodK7PoYOW4PCxm2k9YPmvOyddWwKyNN0hdlRHO02S7FRjqe3OBunQSGmp9VvB9ftnOnqXePjdL6JHBavd9BM4f6TjxMFMD2NYPUVOytfS69m9O3zusDAFpEYL/HAubtDUOHKj0XyMA+Oe2kzrTOZQTGri4vQ+bGAO6BlKuaYLJeEkOFXl+Ma5zrkm/GaWQ93hdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68940ceb-2f7e-4fa3-5a38-08dec5490ad4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 10:31:03.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6b8cEnKU48IKl21HXX5fyaL2srjFX+6Gf1WPYruh5EO8kZ9m0GSM8gXtKlHrp8HRarkA7xkjSYL5V8VT6r0VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 09:23:21AM -0700, Dave Hansen wrote:
> On 6/5/26 04:42, Kiryl Shutsemau wrote:
> >>> I don't see a reason why we can't keep the scoped_guard() on get side.
> >> One additional reason to drop scoped_guard() is that it mixes cleanup helpers
> >> with goto, which is discouraged. See [*]
> >>
> >>  :Lastly, given that the benefit of cleanup helpers is removal of “goto”, and
> >>  :that the “goto” statement can jump between scopes, the expectation is that
> >>  :usage of “goto” and cleanup helpers is never mixed in the same function.
> > Fair enough.
> > 
> > But it can also be address if we free the PAMT page array with the guard
> > too :P
> 
> How important is this patch? I see "Optimize" but I read "Optional".
This patch reduces the number of global pamt_lock acquisitions.

Reference testing data with/without the optimization:
(collected on my SPR test machine)

Booting/teardown of 1 TD (8 vcpus/8G memory) per iteration:
                |--------------|-------------|------------|
                |    avg (us)  |   max (us)  |   min (us) | 
                |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
----------------|-------|------|-------|-----|------|-----|
__tdx_pamt_get()|   2   |  0   |  578  | 505 |  2   |  0  |
__tdx_pamt_put()|   0   |  0   |  563  | 496 |  0   |  0  |
----------------|--------------|-------------|------------|

Boot/teardown of 5 TDs (each TD: 8 vcpus/8G memory) concurrently:
                |--------------|-------------|------------|
                |    avg (us)  |   max (us)  |   min (us) | 
                |  w/o  |  w/  |  w/o  | w/  | w/o  |  w/ |
----------------|-------|------|-------|-----|------|-----|
__tdx_pamt_get()|  15   |  0   |  1723 | 1386|  2   |  0  |
__tdx_pamt_put()|   0   |  0   |   562 |  733|  0   |  0  |
----------------|--------------|-------------|------------|


> If we're arguing about it, maybe we should just kick it out and focus on
> the more important bits.
DPAMT still works fine without this optimization. The optimization can reduce
the average time spent on the global lock, especially when there's high
contention.
