Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793994718;
	b=rOS3V8pX4HTGBF9zr4hEmX3DeMX3Rqc0110txWF7QH4RYQXmx5kHlOYyB+9CI8rslzxf
	 oskLMT3O+baV2/sNN0jxmaGAlNR1lpzVob5WjyEFY1+TCCvIFPV0dc32obTCebhRfVe/Y
	 mMf/MCZrNRyyJNzJ59qPlyVSqKJoHf2jwnA/mK3pK2m7oET6ivd4dd/3n2NLjPNp7Af+Z
	 WELmjnOQpGvS3/Eu+a1QRn7CExq3hJySj57doSgrQ6PZDs1kyznBCJ7+OZeMoxzjkvanA
	 ie8gE1xYXvogqgWbAcjLMDj1FlrVtBaYmO+gdhx4DodYzm88igR1+sS0hBDaDEmVndQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994718;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=bfJVYDRZPCzuUiebsThLylwoiwZ0P+sPcKXbxejbQJE=;
	b=DDd3u9aWobzBIXCTCKyRVIU2YmRuecH3imiJoXee+tdqgUhfk8UfaiuilBfzr6LQYf0M
	 NyEgFQesShUM4awq+h2qHY5x+2RRb45W+bps/yT1yZLTWPIoZJp5yVFD4LY+k1FLvlTPj
	 tbp6QB4sY59m3M5gfgru+OBzXv7MtXd/Sac4lkEKRREGpCoRvp+2SxPEjnjTxlv4akr5Q
	 mDr3VCu6M+1s95xM7lGmaAOQURwzpqjberEzukfbysS96/NzUTisKlVwUk7tr8i0CkOYw
	 Op7cVWMEEdokDHy1AHdJXsA8NlV3z0+BaVNJFb5kDUqvVxSlxMrYKvW+wa3xeP7tHww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mY1YD1v0;
	arc=fail smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B2606A336;
	Fri,  6 Nov 2026 19:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9B2606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mY1YD1v0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793994717; x=1825530717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qp7kf/c40Y6K8xfn6IhhiCd2rjUXbl/h5mOCJrc7YLc=;
  b=mY1YD1v0AI/PbFk+nSKw2QS3Aunl9Q40M4ic8pPWyKyHlb2/hTsz4P/r
   wSLDg4gNPTBf5gTf67DbquDxxRulexbXKU9w6O2iXZ1vWTXjXnK09/5ih
   40brMHRomn5Ky5uU931yATa8IqIXaCAXgXy6SvAMDzY7DnUoTUtDJ0YnL
   fjmNhC/y8Fvv/MbInglpaL0TphX7lgsFcn3fdZ7AdO8zVblwwfl1Xarti
   NS4paDfjrMIdH3/0oOnfu26nznwJyQtL3/URvaph5g//s2mMe1aUeleFS
   kDOKvmVBPNirgz3A8BTU/RIl98J7rKIr80BDgjHm1HbkilzZQFokbMusy
   A==;
X-CSE-ConnectionGUID: a1ljmfwIRr+pOBtlqbbCxw==
X-CSE-MsgGUID: 0PxaEgc6QZWmOtPqGSX4Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2815568"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2815568"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:51:56 -0800
X-CSE-ConnectionGUID: 3RVlC9NsQ32odlwVgLD+xw==
X-CSE-MsgGUID: MwNR/AD/RTeb2Q/lIDGYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7695853"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 11:51:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:51:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 11:51:55 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:51:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIEuDCZ+QTxJaucF3o5tRoLd5jBL6G2GAU030W4BwrbdtJgmUkxHX7HiJ4mFWVxrs5fpdB+Mx0sN72cVjsXD3Od63NGc3x401I4m4enSzgJiVG9mP9dOkfhtlL6ACm1bBVoT82F/fjsDSN0KGFX84587KifacLN2WR/LRwiOkuchJTqSdyAlDXrEBo7ld2XIYN5Iqhig7TI4B95lnRfIzCD5TtE8x5MsoR2KvRyB58M6LRNanM01bpPXvjq5ZRzwCrijbCIUOILRYV3DnQ2twoWcWh9hHV8A4qEfPZiyAXkEs2gwKfqWQtJid7oJtbelEAKIftslU8YPqjFeHR+nkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfJVYDRZPCzuUiebsThLylwoiwZ0P+sPcKXbxejbQJE=;
 b=x3v8xL90Gkt866kAIqIMG6dGKfkWnnPHhG+cqbWOGH0c1t5XnZNC45jwNv2rF+j8UeN/FbaexQaesjjxzyToL351+jNDbG7o+M9m8HujWNR//LMhcc50Q0vAJqRLVw1CPlya2GO0L18OdiPiLFgJLEYWgkeu/swCtPhdImTfAgQD4Q8TlPDxFYIbYmFJSOtbwGBHBO0x8Nk4RdygZDhF1CChFEARqaxhChAYbdIbsgYPrdVysoKMi7P0UQ+IXGKRvGy87jg5SduLv7cOgE/vS8UHUo4cjTy+B64exe6FEvWv3S3dY7NVYHl8zJSVsTUcw8A9pWMza+uL43xtXZbH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by SA1PR11MB5826.namprd11.prod.outlook.com (2603:10b6:806:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 19:51:53 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 19:51:52 +0000
Message-ID: <15bb5ac1-d65f-494a-b47b-5d99b1626e1e@intel.com>
Date: Fri, 6 Nov 2026 11:51:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/28] KVM: VMX: Virtualize FRED nested exception
 tracking
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <kvm@vger.kernel.org>, <x86@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
	<hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Nikunj
 A Dadhania" <nikunj@amd.com>, Shivansh Dhiman <shivansh.dhiman@amd.com>,
	"David Woodhouse" <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao
 Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-14-sohil.mehta@intel.com>
 <a77b4273-4d3f-464c-8ced-f6b958eac9e4@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <a77b4273-4d3f-464c-8ced-f6b958eac9e4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|SA1PR11MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec7060d-69ab-42b1-a84e-08df3c3f6750
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DKj5ovfx4I+6s9tkm2NKvwyE8BKs5515ziUKC6IqBoJeN4FRhWim2KRjNSZOzvcqTh7m73McgtKz2ckmKzc+F65KWqX6+AqA1MLr49Iqyn8LOJGEaQ9cn3O390bsJY2Dmv/rHZt2OlUqiiKMXJkNeJBM42FFptgszygxkZU2Bxvnnh7PIq+/C+80RC126GtrXFkKSg0n7sReEok+jCfP85SZX9Wo6xoDK9YIFNdekqGES9pXo/43QRh+pC5c7JORrKzXeVYCaaf77RjebukPjvcinPfi9pB76Ot8XTBxViT41vVUcUKg9Y8lsmS3qlaeqK6M1ZTttoHkycHqGJ56xsD5JOhXFL+j9d/vZdgNiYAQM7AvcLUat/g/ccvnhGljbMEHl1pmIrwqiGLyxPZYQg9GyMf4V/QgFMNf30/oAM2ZH9EUDBVYKA35igsit3U4WN7m5ep0C8ezcqmKNvIYDhPy72ZdqoDSZKElj4QTPyz6DmtnmxghXlYSh8q6FFWcaImRfo5aw6Ioq2r8lB5E2D6M82Ur2KsUNGu+Ol/CjVawxINmpE1Pta61NML1FN26QBePIRVDh0RQl19SUQyNoVNmy9KqijVsTtncIRgzdA9XFoT2moyTwAT7Pbg2Zb2ndnSb4VYGOvYD1Fr1KjaQwqH4uvKf9VmnF7IHrvW5rgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZDQ3ozczZwVlFwUndzbHcxYVdRUjFhUGlvejB0R0szMzVXOWtVUEd4WWx4?=
 =?utf-8?B?cUlNV0laT0NZUFVTTWQ2MndhSEtZeDRSZ2RpUGhZSFVNcE5XR2JJczBOcEVr?=
 =?utf-8?B?ZDk2anpRK3NzbHZuaXpkaWE1eDBPUjJrUDQ0Z3VieDJTaVkxTXE3WXc4ZmhO?=
 =?utf-8?B?aGlpM21OYkJNaVNrS2QyMXc0MENyaFFwUWpCcUpGaTlaZXBldWVPbHZ6NXg4?=
 =?utf-8?B?UVN6L0Zmd0JxaXN2MU95dmdkTHNTeVp3cS9mbG9CcncyMzlDanhRQkp6d0h3?=
 =?utf-8?B?RjlZTFBKbHpkMmlCdUhPekY5S2lpYXc5N3Nmb0pKZFllbkpHaEMrYS9JQzlS?=
 =?utf-8?B?ZTY3RTVXY2ovK2kvWlNOcldJUUUvSkVqTjZoZnJ3eTlUNVNZWWNBTkpxUVJh?=
 =?utf-8?B?ZDJkNmxDNEt0WGNsc0lZaGNvSE5jWmIvRE5oclgvenpJK3FraTFPTm9IdDVT?=
 =?utf-8?B?U3RjZ1pnYXR1S04rSlBBcFhTdXpaR1R3ZFhxSGN4K1dLaldxQzBMNGIrTWNJ?=
 =?utf-8?B?T1MwV2EwVDROQ0Y5cDl2UmpkT3pkd28xUDNWQkdNUDI0c2hGck82ZGRUNEFt?=
 =?utf-8?B?Ukw3RFExcXJNNUNWa0RqMVB6SG5pWC9ZU2xUL0d3VEJBQmRycTZpM2x1aDJu?=
 =?utf-8?B?NGUrelVVSk1UaHNoR0VYOUp6dXZ4QTBDRWRlb09IVlM2Tm42SFBXdllsVkpk?=
 =?utf-8?B?dXh1czFEL2ZkNUkyMExISWhlZHFwbC9odFZyR09oTlNBRjA4MGk1cVR2MFRt?=
 =?utf-8?B?OGJndkt1MzZiemFYUXZSemVrMWVtOXJLRm5aN1JESCs2NjVlbUltQ3NVOFNW?=
 =?utf-8?B?aXovVFhHOSt0MGp1Z1BRNWltbkRYbW1FNGNRakJVNVRGek1hRk82MXVpV3NQ?=
 =?utf-8?B?VEhCK3NHbGdxZUhSaEZIZlNGOWRmSkdwUHRXVTVEeTl3RGJoQnZuOGc4M09s?=
 =?utf-8?B?bFZ0aWRkVytCckY2UVRWT2VqWG5wUSsrYTdTd210aTJtL1FFekpXQS9VbFFQ?=
 =?utf-8?B?WlpoNENieHBxUVBpZ3B2c3FNR2JDUitLWmxPU2ZkdFh0WFN2ejd5dmF6ZEgy?=
 =?utf-8?B?OWpYVENQS0loN1cwbkFsdzZ1NWxOV0xsMkVzMzBFUnd5ZG43SlkrTDRicHk3?=
 =?utf-8?B?VUhiMkZaaUpGK3RjWHRlNEFEOFNEQ0xwejc1RjRzK0hmdEVZUmRoYkNiM1lz?=
 =?utf-8?B?eWJwVGlYVVBDcE5pSy9FSEl1dHVPUy9KaHpmZlR1ZVZFWk95bTlLVU5tUE1W?=
 =?utf-8?B?dXNsVGFpbGEvOGFHTmZuS2grYnIxODJ2RGFmQmhDNndqUkRlYTk2bUt5RXJ4?=
 =?utf-8?B?MjZqZUVjV1ViNEJsVDRBNnpod1R1THR0UmhlTjA1dE9nNnY3N1B4MUl6RzN1?=
 =?utf-8?B?cTY4aURrZXdGQnZybWJVVDVyUWxKbUxwLzFLdUphRC9pZTdCRHFESnNpV0Nn?=
 =?utf-8?B?WVRNOFptakdhcFZ2Z0VIUE5hQk1lVFZ5VjhHY3Bua0xCejFrSk1oZTF0V05X?=
 =?utf-8?B?NStQMFVTck5ZN3NhcnVkeG9DYjdkaUJtWFBFY0Uya21qcElPK2JHdzlwYWx2?=
 =?utf-8?B?S1pidkdCM2JmQkI2bDFXcm5LM0RNa0tNdm9NZENWdUdNYW9iWldSSzZ1eFc2?=
 =?utf-8?B?b1loMHRBRXFFY1FFaDlYVUtSWlVzTjIvWDR3VWcranhjd0l4ai9Rci9hUXFR?=
 =?utf-8?B?c0xOT0hmaTJVZkxSMzZPNGE4NjcyU05NL0Y3UHRzUERmVzZBKzJBc0pybjVr?=
 =?utf-8?B?TlhpMkN6R096ZEMyUEFFNDBzMi8zd3Vmb0loc2Y3MXlaUnlCbnJYV1lnc0dL?=
 =?utf-8?B?UEtQTU93bjNCVHZjUGF5MWkvMkthaEQ4SG1Wa2xNU2x6SDl4Wi9mR256SWRn?=
 =?utf-8?B?Wk85Vjd4VDd4R0tZNS95VkZVRlB3emZNeU52WUh6RW5KTnpJcXhoUmJnMXkx?=
 =?utf-8?B?bmNHaVpaZm5oNDUyQnNhaGF6dmFqa3IyWkpjeDFYQVh3YkdicXh0RWhWQmM5?=
 =?utf-8?B?cVBZa1pJSlJneXhVTFhRanA2MHA0Qm5MRW5VVWdTczk3Z2lkMnFaZXgvbHpW?=
 =?utf-8?B?cmM0Mk05RUZGczg1TnRJb0d2a2laSk9MUGtVNGdjK3JLYXc3NTVIZDZ3TExH?=
 =?utf-8?B?bll1VUo0Ung0Q0xaZk1oTUI2Y0Ixb200b3NXeW85RDI0WWlIZ1RrV25PTjFQ?=
 =?utf-8?B?NzMrNGdmaG44Wk4wRzA0VGg3aHI2SWY5U0pOKzFJWU1zeGZpSW43UHh5VjVp?=
 =?utf-8?B?bmdJUDU5QnpOWjhWb3U5ZzQwczhkeWhKN3k4T2tEc01DelBZQSsvZkppWjM2?=
 =?utf-8?B?Q1dSaTRiWnNZaTlTWGtxK2htdlcyeUZPQnA1MVRabmN4QUpzbWdKdz09?=
X-Exchange-RoutingPolicyChecked: FH/MgdkUBjo5oxD0+F7jJTteL1b3XvZ6xhrRaSAGEvB4AbeqDhBrGWbU5jKXloUp4QxeB1xWwSBPBxJJcKRlhaA3mhneJPJOxB08GhXsa9+67phjC92jCGaAnOblC57eQyU8j0P5EPQ/45lsxhhQ4tfF4MMZF5l9A3OO9aQRjaK6WfDI9McACMQWbu+thHNt16Xqy4hiNyxwr2Q9uRmTdbBBasPjamyWsmyf4V+hljxEP9Vh5PFVbjPAMdQ8yC2QJtOGZvGZg+Q+vBRqHAtAA9apSgWvFRhVTFrQlfoj1US3GMDmEepn9Hyf0cOrbxidZA6N7P3U5fkq781XzX59+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7060d-69ab-42b1-a84e-08df3c3f6750
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:51:52.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEwqCExC6yousQUTFNHV5mMydNSi38+Sd0Q3lM/jD/xq1VTxLc0ZjEPg/JBUxmyvCflhgRvbO36xu50YX+KxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5826
X-OriginatorOrg: intel.com

On 10/29/2026 1:41 AM, Binbin Wu wrote:

>> Note, like the other fields of struct kvm_queued_exception, the nested
>> flag is meaningful only while the exception is pending or injected. It
>> is not consulted otherwise, and so doesn't need to be cleared when an
>> exception is dropped.
> 
> Just try to understand the sentence.
> The patch clears is_nested alongside pending/injected in two places:
> 1. kvm_clear_exception_queue()
> 2. When the exception from userspace is converted to a nested vm exit.
> 
> So are they needed?
> 

I don't think they are needed any longer. v9 needed the clear in
kvm_clear_exception_queue() because the old flag was ORed into the new
one. But, now kvm_multiple_exception() uses a local variable. So both
the above clears can be removed.

>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> [ Sean: reworked kvm_requeue_exception() to simply the code changes ]
>                                                 ^
> simplify
> 

This handler comment that got added early on in the series seems a bit
out of place now. I'll drop it or maybe change it to a Co-developed-by
if the original code that Sean suggested is still being used.

>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> [...]
> 
>> @@ -8978,6 +8993,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>  					   ex->has_payload, ex->payload);
>>  		ex->injected = false;
>>  		ex->pending = false;
>> +		ex->is_nested = false;
>>  	}
>>  	vcpu->arch.exception_from_userspace = false;
>>  
>> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
>> index 0f5919b092e4..2d6bae66cfae 100644
>> --- a/arch/x86/kvm/x86.h
>> +++ b/arch/x86/kvm/x86.h
>> @@ -158,6 +158,7 @@ static inline void kvm_clear_exception_queue(struct kvm_vcpu *vcpu)
>>  {
>>  	vcpu->arch.exception.pending = false;
>>  	vcpu->arch.exception.injected = false;
>> +	vcpu->arch.exception.is_nested = false;
>>  	vcpu->arch.exception_vmexit.pending = false;
>>  }
> 

