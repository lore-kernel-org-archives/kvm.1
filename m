Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D937F723;
	Mon, 28 Sep 2026 23:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636482; cv=fail; b=mrYfUmx6qPwvmcLJLHyon8sBJEj3AynVF8bnt98JfQ9VTWd4VL+fPm4L7uEv7L7pvECniZnBAVcFyvuic2tHQ4iwcCFbqGNl26ELQEA/CmruY1hmcUV66gGJctePLYZ7zfJ2KUqFjA+kFafT2fzdk7RK4QHwQfddOz1Z62Yl96g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636482; c=relaxed/simple;
	bh=Ma8LY0PGbGVtfE91eEy0TrtJpRHMJJ3mL+7DPk2h2hE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sI+RlxwzMo1rExTawJhKWKZapzK2Bnq+/SLtOCUqzlGLMRwODpBg2E+FDVnlkFfZdilSRczvLxvx4u2jv7CzDa0d6XZMmImrG9PvekVXBo6bgWaH7VAZ76llUlumCpkAoz+NNveBYOvr9nGrj1SDsFiS6LJSny6FtFtgJQjt4dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/DGKFOj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/DGKFOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636481; x=1822172481;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ma8LY0PGbGVtfE91eEy0TrtJpRHMJJ3mL+7DPk2h2hE=;
  b=G/DGKFOjS7cPtepo/i7TtunUZtYYE9iRpMkSOaJyGWzd4aLLGQXqm0k4
   6lFvMkzsPfhFfKauv1Vu7y4riaAhEorJ2VP7NFbONQufkKg9g0yV2OkFY
   5R4SPnKTeAjojLa7pm7g5s7rStmponHvYWJV/p1FFCg6Mbo79NK2RBENI
   qAt+6QugiC9Hr1PDAItpbjIyPxYKq7o4puF3z0lQUhuR812xpwhS+aWH1
   wzfdTNhfdp3Iy51UXBH7j/9aGSjyx+izH3qgogpP8kjfH+QxLftphgyyT
   giKhYyw7Uapv6ntKk6vvDL+x91DDLsOatWnLbsAAfYevv8UlP1IQT6J1i
   g==;
X-CSE-ConnectionGUID: CI8dL1vJRpSbn96zWR0fww==
X-CSE-MsgGUID: tbmeQY96S6msjTTn1sAASA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="95160581"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="95160581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:01:20 -0700
X-CSE-ConnectionGUID: aYW7NfaKTxy0v5ECawgMYg==
X-CSE-MsgGUID: ZeGYkdZ8Rbi/Nb96huRRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="274694033"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:01:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:01:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 16:01:18 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 16:01:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBW8rzHdwQrvyQESeDbVGfBhvHMTNuqFKSGDO15a+rcpzCLgIZFneYqslXsrLp4yCIybWWG9udpD78uk3uwDk6LvRUIVizWVDhABma7qxivsZb51cb8BHDDjQ89GWKbGsAhFqXrxL7u11tz1c9+JXSAfO3xuO2tsCBsdQP1WUVOirh5osvds4afbjYtwJu4d1IT0Z1iRvQh5o64+Lbxls/v9Arz0M8zwwytbumrmok2cVhxLKVh1oBv+U7HqNGPft+aT7d9H1P3fHpHiHg0Pwx9xAz+gzLPDcHbsGYLWzUba19TH+KKswcPilFXdc6erDVc4jT0DZ7ssfkzp7Bj3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB1UEt/DLdaikjekxYficEP1+lJld6CxAEu1cGp+yjE=;
 b=KB4yOp5vXaw/+nJVL2jzbL1c6xhDCMlrJBfvb6bWn2M4RRvr/eYPikKjXcE0Ezmmr/GEUmTlyCKigs6w/L6e8E0UJTyZzGi6DHHW8eDy+BOuOLt4M7ncICeywluFgCYKLKXUM4ae1T/Zn/N7anoM9K1vPhYtlAKjdSA6hQ6pT3RXaKby63stgGZSkkqR80tr0A+A6W7IZ/25QDMfAWFVxMNBwWv03wWRxn1qd53hfjTi2wVta5EGbmGOY/hvL3PYFyEYw5NxCIFunvZxIjnGb5E/fefeusikhxF9vF69qPI+N0oVdwYw7WfoOWEh5QZ+AXQB6p/EqbqNhCu5ydmzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by MN0PR11MB6278.namprd11.prod.outlook.com
 (2603:10b6:208:3c2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 23:01:11 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 23:01:11 +0000
Date: Mon, 28 Sep 2026 16:01:08 -0700
From: Peter Fang <peter.fang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v5 5/6] x86/tdx: Add a helper to query maximum Quote size
Message-ID: <arrxtFgzCahmib38@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-6-peter.fang@intel.com>
 <bd235459708f5233444f31270d8785c0818c107f.camel@intel.com>
 <arrYlnkCq4GDIG9M@intel.com>
 <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec9a448fe5788b748ba616074270242fac5fa79.camel@intel.com>
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|MN0PR11MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: fac52432-6950-4a72-83b8-08df1db46379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ci8VFIEeq9wLd1Z/MaJDMmmzO9zNswk//g03ZEtf8dZX2caF2I3V4l/L1t64nfJctcDJ3m3+NG5vDgHmQwdPLGFnBhqB3BKoFKqukkeb4/tAJGiQkcX4HPy7xn3QBIyIl9yijphqiyi/uxr2D3/U/9nEZhLzjkkPaFif5KBefwF7yI0J1m0OcKP+O4W5UJfz+OtDXYG1YF8OEZQCWRV3+qPPvuHPKEgcys42Suge6ITNq5mCBti3BPTrB2P8E8F+F7HsYD5lMrmAohJ/j0Y/rnnRjSgkVFxiWML/LgXdL+p+4qCCUBlrBodNDNvxdG94XuRpcOtriJ+/z2hIqNobuLqv0vPUcPqL+uDTSty5VJh0lHv6drUXsmFGhD7FwKJcnw6qfDlXrCru8cZFoCcOVFeYndohl/7j7W0hkRRWuPaA1QpVC7OsYrW7E4u7ScHjKDW353bjnfLVTYtLXU6zfx/xe8nYrd0J/MyK1AOyEWNuM9UNCtWWgLWSDaTU/p8eMoplSyEWfRGHsHFZo1ChSs7MxguyQM9crcIhL2ICmTgyPqkni1pMByjxkdyuQQeHjb/ojrp9CnGhO2BV9+qREiunGjGjPghm5CGEGdybp7Qn3SYZytb5jMChR2s6RdQaM9a2nhLFAu8acOGEnHnZI8QvMdr0zNbzIX8x4PBggJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXk3VE8vNFo1MVBGRktrd1VvU3ovd0JsRW91Mjh1RDgvbjBBUFkvdEVzaVRo?=
 =?utf-8?B?aHNYKzBoSkJCVVI2ZW92MFpHYk1nWkEraGRRdjdGMmZYd0o4aVVNL3MzSmdL?=
 =?utf-8?B?ZStIMTFTUXJtOVVmdjA3cm02ZjV3UlpwekV4eDZwQVI5cC9DY1FNdDJqb3ZJ?=
 =?utf-8?B?VEp3clNMRm5YQWhBNU04NUhHQ0tjYXlOcXlLeERmMWxSeGlrSGk3QnR3MXAz?=
 =?utf-8?B?d01RUTNjYXZWeGZXZEQrd1ppOVE3NHBNZWFYZjNqT3hMRnhYL2hSb2xKbnVY?=
 =?utf-8?B?UWJ6a0tXbmRTeEFBQ3RrbkFUWVRZU3kxczQ0NVF4TXJDTVpkSVZPdlJqQjhT?=
 =?utf-8?B?MjNZTjBxb0o0ZWNVK0J4MEVUWDdoeE9MZnhoSWE3RnlLM0F6SkFaZ0U1bTVY?=
 =?utf-8?B?a0JGZThsVkp2RnhCWVpiZzE0MWpuY3l3VWJVRTYza2NTZWhlRzhWbDF4OU11?=
 =?utf-8?B?a1NyRjBsTVkrbkcxc0JnRGFsQUxsY2dlZ0dabm1sMnZsMmpaU0oycXlpNmo4?=
 =?utf-8?B?TXo1QjBpcnZiWFg3dzZEaXBiRE5QT1U5S2R1RGdzakhhb0VlU3dHNDF5d29t?=
 =?utf-8?B?MlMrVEFVY1JxcWY5S3REMmZZTWFMSVMwUk5KNW1qdGJRVVVacmp5WGEvNUlG?=
 =?utf-8?B?a0lFczBsRlRaOEJwK3E3OURoSUlLelFGKzVsRDV4QXVQVDJYV1VYL3cxQ3Fl?=
 =?utf-8?B?dVMzeURDUlNURUY5aGtORHRlcVhhU3MwbU9NUEpqd2NqcTVRZlFMY2hFSVlw?=
 =?utf-8?B?aHllczczbTVuQTlqME9iN0U1NVM2d0ZoT0o3K0YzMnFzK3NEQ1h5NklEdER2?=
 =?utf-8?B?TEl1cjNpdHJkMlR2em1UYXU1cTdJOVZhYmlJWXc5Z3NsUThUMFVHdDE0dXBz?=
 =?utf-8?B?VWg0VHVZb0xVVE81WWJJT3pEeXFad3lCY1phbk5heExKS0J1czJ4elJ6ZE9Q?=
 =?utf-8?B?NmpxQWtqeXZVY2h5UnVtd0hKbXRIK0w4Q0RkYjlCK0tndGlpWU83Tk52T2FK?=
 =?utf-8?B?OHpUenNneWdpdDJ0UFNBellzVjd4b0R6MDJvdmVvdzloWnQzUkRNYk9ucGFM?=
 =?utf-8?B?N21CbTgwd0RDVnhZTlhDV2ZrYUhyeXJibWdtYkRDN1ltciswUFlpMm10cG41?=
 =?utf-8?B?N3ZSaG5NNHR6bkNiakIybmdRWnVtRTRLcTdqbXBuWXVSc001Y3JxQVFVdllq?=
 =?utf-8?B?dkNKWDVMdEwrQ0NGb1prenhPKzQxT3lyemlIdmloWUhRaHZlbWdyd1U4ZFZr?=
 =?utf-8?B?bjdLcXBWMzFDdFVya1hneWlmNm10YkQ0UjZkdFhQZFBmbUhJcmN6UFFsRVJR?=
 =?utf-8?B?SHhCbGEyWjZmR0xpS2R4Lys3UHhGTU9scXN1czVDdmdNKzFYMFYrNUI0NGl3?=
 =?utf-8?B?S3FSdUtnbHRJK0ZEeGlzMzhMaHhHbG9OaUl0eUFIcDBpMEpqajc0azY5Wng0?=
 =?utf-8?B?d3lzZ2RnWmxqSkRlQlpWTTdnOXoydWlKSS9zaUVHRkRvcks0SDNxSlBEeWJv?=
 =?utf-8?B?bXREWHZCR0J1bXFKZzA4MW84eWgwWHQ0MEh6VENEeFNhd01yWEdWcCtaRk5s?=
 =?utf-8?B?NFNvYzdjcmZhTGtzNnpVaktDbGZ5YjhsM1hOWXAzU05XNTJEUU0yUGRWa2Nm?=
 =?utf-8?B?WHRYb21TL3pBZEp3cjhvSENXV0V6MkVYVG5qbmlCd2NQcnJVelZCNlNQNEZh?=
 =?utf-8?B?bTB1YytPdUZXREdzMHJwU0I1VHYyMmRJanBkVlhzeVVnVWlvOTBQUEY0MCtt?=
 =?utf-8?B?VnJDaWRlNU9WSzUrOTRYNWg2RDFFUVZtd1V2eTFFS3drektrTGx5czlJalcv?=
 =?utf-8?B?ZjV4c2hSRllIVTRoS0JtWkV2T0ozWnRpeEJ1dENZaWdBNlBTakc1ZUFuNE80?=
 =?utf-8?B?WkpxdWZSY2lMKzY5RXFGbzI1cVBjNVhwWEFjYkdncFY0bjF0Y3NJUTM4VFNk?=
 =?utf-8?B?eGIwUUg2eHpJTm9hNFhxeTZTTVZud2c2Q0hGbnBUZ3FybzRha2VVeEttdTlo?=
 =?utf-8?B?TU1jempPTG9LNnVTVDdXQXd4ekt4NVc3M2JRNVBnLzY2N0pNemhtcWJ3UThR?=
 =?utf-8?B?VkkwbHM5UUVrSWdjN0FSUjRFMEQ1ZDc1RzdoVVFoM1hYTEtzNkV3RHRzSTMy?=
 =?utf-8?B?aFhjZGF5UnovZWJoWnFWb3A3SDBjMXpwaW5ZMjNjWmE3MlMydmtpN1FQaHF3?=
 =?utf-8?B?Qzh4OU9obThDbVZLM0tZS2lWbnFpbkdHL003RFhjcHVpb0NWRHdBaFBLbDZO?=
 =?utf-8?B?Ukx5d1Y3TXQzZlpNTVh3dytaT1d2djd6dUd3Mk1oN3J5QWNEd3hrSndNSVZZ?=
 =?utf-8?B?NnFTZ3JLaFhDQnc2aW93eGFESzc5b2tpVmhPODNPdHZDN2tQaUFzdz09?=
X-Exchange-RoutingPolicyChecked: tbc29UuUYDz/E4FzqtH2aqSCzWwE4c3BStL25mcBtZbTArTVIumh1Gk0T/fyPKutnlhGCbv1heGgxssQSriLXvRbfFzrRbtcimaqv23aXTg9ccvBzmZCdJp+s0uwQE0IctXqAQx7WoAT1yw93ZkJxI2v6JFMDl+Lod/i0lR1PcpyHnrgTmYb14pYRHJhYvfhespdhdTTZCEB7Gnu+D3MhoTgmqQ5i06rCla4dZVVQa1jsE/8Zftwi7l2qVNCNob3UwUe5PbD7wcthiFm3vuJyijRaF0KqfhofzHFIlIpLGvXK9p+ZrvFLK6OEd9f+TTxcmyF3Vsc1FOllWEDcJyvcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fac52432-6950-4a72-83b8-08df1db46379
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 23:01:11.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nA/INpHEKEbytR7Wn4trXtuGENrmohrkTMB2UmE1xiTVdycmpbQN5oXFJq6dTsUwHTE/0o29aZkwhoaWunFktA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
X-OriginatorOrg: intel.com

On Mon, Sep 28, 2026 at 02:25:16PM -0700, Edgecombe, Rick P wrote:
> On Mon, 2026-09-28 at 14:13 -0700, Peter Fang wrote:
> > On Mon, Sep 28, 2026 at 11:50:32AM -0700, Edgecombe, Rick P wrote:
> > > On Mon, 2026-09-28 at 03:08 -0700, Peter Fang wrote:
> > > > [1] Intel TDX Module ABI Definitions, August 2026, TD-scope metadata
> > > >     field "TD_QUOTE_MAX_SIZE"
> > > 
> > > The latest seems to be June 2026:
> > > https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/documentation.html
> > 
> > I think that's "Intel TDX Module ABI Specification". "Intel TDX Module
> > ABI Definitions" was updated in August. Yeah these names can be
> > confusing sometimes.
> 
> I see: Intel TDX Module ABI Definitions - ABI definitions in PDF, CSV and JSON
> format - June 2026
> 
> Ah! There are two listed: one from June and one from August. The August ones are
> still labeled for community review. "These documents are not final and are
> subject to change based on feedback."
> 
> This means that we are upstreaming head of the spec being finalized. And TDX
> module will not be able to change anything we depend on. We need to make sure
> they know what we are locked onto.

Yep, once locked in any additional incompatible change will be flagged
as a bug.

> 
