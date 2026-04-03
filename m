Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB82857F6;
	Fri,  3 Apr 2026 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253923; cv=fail; b=smLVhKNtScbdmJr5kxLbziia1sMJmw7j0hVWtc8cI80LqMzoYERtFQMYrEqfGArI9RojUsHXe7Mdr+qNO4GNN2Gm3GJkGDuDH5S9xoSFBUgTBKrQKYF2HJBgl+AESGN0RtVvszIhb1WD+CBoTtrwNhzzxMUXX4JKTBN6fQlYu6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253923; c=relaxed/simple;
	bh=SldzVnPqh1VrxXf2WUK6pT34+WTh2G61d2kli6vF214=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SNNtz5MkI2I0tGOV2ZgvbaTA0G/O7a3GnD2A0kbRUH1rLYQY4VeeM4nUJwAG2loMIHSQYYcYDP2bMYZFyfurtgpy4Jqk6KWRNdABiX7AW/7avqE6NF4jrX0M2RbXQTGjhouIOweVjFMfAWWxVwCunt/XGnJrsO3SY+rEIhuGPE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9+vbUro; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9+vbUro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775253922; x=1806789922;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SldzVnPqh1VrxXf2WUK6pT34+WTh2G61d2kli6vF214=;
  b=L9+vbUroHrEKbgxEmqcMNMgZ9M8kfCWWD2vxseYCogamHhPLGDVeMXIj
   OMcLYyx44HGafUhJ7d3eTBB/aaWqZZ2Lyt1obpIkRGfFcuFJFowsUz1yq
   f7/RYkhdfIW0cAofuJW3HwCz5aZuDA2VrZxlG63E5tHxYzmiNMLyyB7gv
   BljIqg4JM1QHhlLnCP6+TbhTsmCwEfDsSeAaLy0v8L8dlfwbraM2XtndN
   aGAcG4o3kPq69iEPZfEAalCqOAyVKkUY+XZOnLgSW9uEmoZT7OJ+LDzff
   DNqgk2pDDMyp/HtuCkniNjZhoo4/NtOpPWfDbRRebG/7Eo/ac88MUc6iL
   A==;
X-CSE-ConnectionGUID: kqHVa4sJTaifzw5e5nNV5g==
X-CSE-MsgGUID: DplJj446RFiM4e7CTTuMWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="93899564"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="93899564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 15:05:21 -0700
X-CSE-ConnectionGUID: PBmYawI6QdyLjZSb6f5eOA==
X-CSE-MsgGUID: 1f8aGmJgQ4KDzR+gPsNwQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="228984845"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 15:05:21 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 15:05:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 15:05:20 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 15:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C63s8ntqAFc0hzcXqYsuQoX9J7qIsxTrTowvO6IsrNzdbz0L21qe5E4/hduT3WIAOvak02ZAuvVLf4n0PKKeoYWtxBjUUElkYij05HOwdD+c6qYXUZVXOJleGn25UMxeePci016QjhBvADSRYiIpodwswAQHRHNb4s7MHjvoTl29w0Sty+4McG7SsHVPD8QfozMW90orggbbLhUEzEqHWtTGXFIsrGoL5wJhhnRBuOocYStB+aAFJu1itBbHohrMRrr1cIbNZIQCiAo0Kt3102OI+vmTfrFE/GBQGoY2c0kIh9rd9Uv8vGDtBpZ2LWxZR1c2rSVwmuYycB7v6t1Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gre5PycfehgMINruJ0xmYlGIEMx5ZqTxE0eWQodduHE=;
 b=cEIweHCdhCB2BMu6lttzPQ55ztxTHhFP/AAtUPTYSsy5Ac+eYQ03OQqFrTCATEPF4V1Cyd+21m0tvEmCquk/SDz2JttBBBdx3RGG+wkhZYpGbPHU8cD0Pw3Rnb3CbaIP+Dbnw8dV1ycODf/8YWKXDmMAFPjBOyh5J3QfttTi43X6VcuAiBDgX0U+IhCw6lzBT6LQETm28pQ/Nc2Jy4N7vc4zJcQCafyWU16WIvRWXJVSr5bh+7PMO8TWlFfQUzrT0g84FKpI1fEdV47ehDizQ92hKFE3pWLr5wz6D216rhiNHy9rc0h3gSKoybxbeFx/Z8Rp26AJNdMxQohEwRcXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Fri, 3 Apr 2026 22:05:12 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 22:05:12 +0000
Message-ID: <aea176c8-35de-4042-bf98-e42ce05f93fb@intel.com>
Date: Fri, 3 Apr 2026 15:05:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] KVM: x86: APX reg prep work
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>
CC: Kiryl Shutsemau <kas@kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260311003346.2626238-1-seanjc@google.com>
 <7ec084f8-812e-42f2-8470-e416fa7ee848@redhat.com>
 <ac75iuf9gHIhvm9u@google.com>
 <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <88e9d7f0-35b8-4559-9f4d-c7daf1af6012@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SJ0PR11MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: e54de42c-440a-457c-b93e-08de91cd13af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: VCikGECvv/VZlEYesVRFAN4odps3eeJNTWGV00CEF/4rCaypyV6UYtThOT6vIhZuYan++SSGqsC0eYQTu6CZBCNsaTUFVvJ3PMqUxsVbBaoeYCFKCQ8Vspnn6bp48k8CEMIEYk7BODMvf9aDInhfEZqUbmaNHG3qczjGHznwbI1ZI+olMC8yyic1nXQyNBMraUqC36M02lHq/rugPnHh+9eLzQ2wmffKlKYcJ+o9dYDRJ9SmU6S4GHvTJG9CdFz8GhuGyznQO+FlrjC4HoxMu8iH3VaXNsR80MwH64lYaQhXUMsGqJ/cBpBCmZHYzUPNceeM1g9VuMoN0Qecz+bI0Y5s7TGCkHacwCeVNF93Iec1xysfHfwMPowY1BwFKY2bqLKWimHzNzkhu6MOBgJActoqG8Qk+rEnqg0leanRD34MACH4kP5O/HWakFDOo4gneyC12UmaOx4QkWkw6Azxg1XDPu8E3dppq6uEXI/7hhz/vm0L+TBx5k/qcoFde6G7hnRtxIL7h7dNo7dbJP9S1AdI17PmtOz2bAKAHoYkf9CPZSz1S3N9tawLbqrkL618B8iBqhYe25aMiVAy53OV34WYPJW62gMyOnrzjusk+rgjF6l/CMmLRXqOS4kUdQJA4SbehdJkn9zPEQB99J9PEIDAYFWbQx+Seg/lG59cmWcec268xw8h4l0/UKTX/s1FF3/3zC8GdqyxRu9pZjOp1an7HKqMHc5EySjPzTNfxsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEhncmQwYTVjMHJCc0RYbDhzMGlMbHJBQmJwNERqMG51T3J0ZjhKN1VjYjRO?=
 =?utf-8?B?Q3VHZzQ2cHR5bnVDRmVTZDh6UmNiUEM0dStXZWtCeGhiZHBwemFHN2RXM2c0?=
 =?utf-8?B?QjZFYTNtaGhpc2I0Y01WVUI1eUlPT3VwUm5HOEZ3bkJzbHZ5cDNteXFRb0dR?=
 =?utf-8?B?UnR0TUx6QXpXTlpBS2tra0N6eGxpWklvTit3K3hEWGMzMDU1VU1FZURqaTRR?=
 =?utf-8?B?YzB1MkZwanowVTQrTHNPQnhXTnU4eXdQYmJlWGxRZDFBYnhRdlZudGJaVllT?=
 =?utf-8?B?N3lURmxmZGE2WE9UcklpeEVTK1RxZHNjcDJxeUswYlFtSll1YmtBMUNIcVFE?=
 =?utf-8?B?Z3NHQnI3YXVrNEdvSWsvekpxVE9raUFUVXNmb1ZETGV4ZmVoYmdUckNPTXp6?=
 =?utf-8?B?dWVCdWpCZDB4d3NsdkdvZHNtcit6WW00Z1B5cmJPVkRiUDdnYzZKQVpvMmhJ?=
 =?utf-8?B?a3JGTDNWcXhSalVJSkVqemhCV0pmNXdvdVMzSERCbTErQmtRSFRwUUR0ZTE4?=
 =?utf-8?B?RmE5ajdxcFRvTUdDbkNlZmlsOEtNMEFxOWovSnpWQTZKOUc0RDd5Qk1rZnJt?=
 =?utf-8?B?WVgxMVcxbkhDZWltMk1QZTlOcnBVMzRaSExQYjhPT0J3V3l2NTVaN1lLREQv?=
 =?utf-8?B?OUZROFk5MXhINUxKTWFVUnhueFJHM1NGRVF4eTN5VkFXODhyeWpJMVRSSU9T?=
 =?utf-8?B?MDdrNjlrejVKTytiNUpqNlZHd1oySm9MWkk5ME9YSTgzVThaK2xyUVl0M1k1?=
 =?utf-8?B?MVNqOExnR3VjbDUyRkRBVk9Idkc1TkpJSU52NnlGaFRvMUFuMTFaZUpwK3Fm?=
 =?utf-8?B?bEdBczcrSm5LZ2F2RVNqWTVIMXpML1JBU3E0cmNnV1lNRFo5WVYwQTFsbkIz?=
 =?utf-8?B?VkZKayt6U0xSbVV3VTA1N1pzMTJUMHJ5S2tZczJ3T1g1UXBpRGFwcllqMC9q?=
 =?utf-8?B?K25vWkRNZUV4S3Q1TngzUzVYUUFicENpZFp3bG1DUGtweERhZEJabXUwMDha?=
 =?utf-8?B?WXFTcmtON0hPTmR3eUE2aEsvL0k1MXhwSzlJZnhMZU9pWUlJczQxYmQ2TXFt?=
 =?utf-8?B?S051WVFReFJycWIzTzRVcEtYL253eGpYQkd1K2pJZVFuT3dyOWVYQVJlRHhX?=
 =?utf-8?B?UitxY2lEQ0NmcUZvQ0FQTzlPUEQ2ZmlYYW9EaUF5cjc1RmRRUmxqS3RHWVpB?=
 =?utf-8?B?YmM1YXR6T1BWbFFGRm8xVmJ0UGZQRWhDSlBxY3JSa2NGWTgzOHRncldqLzRv?=
 =?utf-8?B?TTQrWUJFbFIwbktLWmNBMUlVc090WitmQ1I0Z1lRcGNqaXFqSDBjVGFPUzNP?=
 =?utf-8?B?ZnZ0MW9HK3g4c0ovMW43NjEwandJN0QyZEJ4VTJ6MFRRWFZnTnJFNHk0M3Bo?=
 =?utf-8?B?TVd1V3M5RFV2cEp5NTZ2Z2tZQ2VDNWZFdWMwZjVjMkNpQVRzZFdIM0JqS0JY?=
 =?utf-8?B?eldBWVhkOGpQZCt6YTltbFRCc0lzb25maHY1N1poOERWbDNjbUlab2pocjVN?=
 =?utf-8?B?eUhnVUNPRmF1eDZIanlZdWNsVVpncEpSTkhqZlpWZVF4SE5WK3YvcnVVb2xq?=
 =?utf-8?B?STdIQ0xseTUyYnZxTUZRaVNBSXpqU0h1eUwxMzZGVGJzY01FeXBqdi9tWmRk?=
 =?utf-8?B?TVBrZnd0SWZoY0hRMFlhQnhNaTJxVW1LTm1iTTVBWWJpWnNpVG4rYnNLVGl4?=
 =?utf-8?B?aUw1Um1QM2gwNWYxd0dmU0Y4RzNLYkhMVlNGbDFya1llRWdYcVM3QUpoMjc5?=
 =?utf-8?B?ZTJadWlKNWxBMkYrQkhQOHJURUVZSUJYTEIwbm1ONFNGN0ZLeUpEWENoVkpu?=
 =?utf-8?B?azBaTE1UTlYvT3NQczNyRnl4VVFHVENuYWp3ZW83b3FMSkJvUnhCelFzdm00?=
 =?utf-8?B?K01jR014OE1pYTBrclh5V01IQXgyM0Q0OUhtMUh1aGg4SnMxZndNK3lUcWZm?=
 =?utf-8?B?MjY4MEdHVDZacGxEZ3dQR253eEsyZ2JwT0xaVitYMldnSG9PMGNScXpTREox?=
 =?utf-8?B?VHQ1YTRrQUlJdSthYkdBcnVFRTMwSk5PNndoQ1pQUVErYWVpU0N4VWgrRWha?=
 =?utf-8?B?ajBZYkdUcStyUzlwZWZnNS91ZHJsRTQ1YjhhdTdERHBlaXlyd0xBQStZZVZM?=
 =?utf-8?B?ZElaUGFOY1NzTGRxOXJqYk1mMlNSNjBYMnphSWUwdTZFUjdYZXZBbnR0UDBI?=
 =?utf-8?B?alZPTEptUVNreitiY2U0UHBaZHVXQUFUSDQyM1RlRDFIZ251czZ3L0dlR2R4?=
 =?utf-8?B?R1NWOGxZWmFlV2pJamVtYVdlM0wrZk1iaGN6WGNSdHNPQ01pcmpOVE8rSXht?=
 =?utf-8?B?cHV6TURrV0RDMHBjSDU0SldRYUV3WmlDTFRGdEJOenJHWEhybFhyZz09?=
X-Exchange-RoutingPolicyChecked: q5wgJZPr+BIsy7WOUt8ACXZ+ie+xQSIYaCzAjHMzwalOZ+NbZa8giEKZoFSJiOTX7x853gY0xXdE7a3eogE6it7yOdqKDnfhJ7/xMIGT1gkCfxXDT7FznGL+SySv/ANBzcHV7qJU4BKzNEtxs2xeguT+pFherWqOwe71l88WL8mdI7CxRJg6E+16tIMDl9IUKSxaEIqTSO9zuxUb558AL+EgoOWmVEzv+MmLu9oalYRamRBZJ4ESUyLyF+skYlNJiloJK/XxeLMB8BMm4oduutKsbeuqmu9/jJ7gyf2xgyG8ejl1RMfxVjYjst9QznJ+0uWVbWYHAgEOdnUQnGZuuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e54de42c-440a-457c-b93e-08de91cd13af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 22:05:12.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O0GLcEc5zpJBH+u6T7ZPkU9EivyMkg6R6Mf8pTIedbQRejsWYyp+pNBbuy65juOMBei2LAz08jLshndX/upXvu1qe50JLX0WGdzHCUXGEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com

On 4/3/2026 9:03 AM, Paolo Bonzini wrote:
> 
> But until the kernel starts using APX, I would do the save/restore near 
> kvm_load_xfeatures(), because __vmx_vcpu_run()/__svm_vcpu_run() would 
> have to check whether xcr0.apx is set or not. 
Right, I'd much prefer this. Then, it requires to audit whether any 
fast-path handler could access EGPRs.

But there are cases with the new {RD|WR}MSR (MSR_IMM) instructions that 
appear to access GPRs. Because of this, the EGPR saving/restoring needs 
to happen earlier.

