Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793241771;
	b=YbkK0i0dXzXT5P8S+DDyhv+y/8IPbuB5MpDX7VWI1Y8K/snpCSpmWvM9cqFkZh1K9G8k
	 C1CFRtBZa30ZiU3meBxILg/C/truA52Mrj2tvesUckjhSUbvFqYLXCHsKuzBqx9wTHLkY
	 TxlB1Lu+7u38AyJjVG0thhH1PSWxDJCeuJmuDV86DSeSEf8tjm4X30jU8FcqJ/TwTTNF+
	 uL2/Kj9lDpIEpeWzZcu92EECdAjzC6mxYhH3kAqARIj2jRv4LMCyRX+fxB+tI9GHZO90s
	 bYXAd5DMffuv3VBvmn9XKMGrdDQKiUfejxpiHx9T0DxFE3eG57VHvtWbIJtYenKCl6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:CC:References:From:In-Reply-To:Content-Type:
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
	bh=HU6V5MGMmFRvxGxm1Sgtfqx/t54LbuID7smzkmEYZKA=;
	b=zBCPV5CwSrOaIYGyIwInvK1qmMRx744icHUl1Ypy+LukoZX5eLLCqgn30/1Y2R3CWANT
	 Ksp8BvAwRhfGK9Eu5qFI8vNMkbZ+PHYyneuBN0Ckdox8zoM2bix4oJpn4dDQQAeZ2HNMc
	 iKJ2xILp9bG/q+uH8IDGj/ilLHJbXCaQkg+7m8/bowZ9Ud+m+tZSamKnWsveBIDJ/ft4q
	 g8Q8X6JI6/bxwH5A1JihCkvn2G8ctxfVNedmKzkUdjfLs3kyIIWNQ1lfYWsDM5nsx56Bc
	 /Mhkx6ETmqRNcLMmFwTeO0LzJcGTkeA600EuzWUkwbCFrkindpAYeBUCZKKKNJsLhjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="cf/3KgOI";
	arc=fail smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D0606A31A;
	Thu, 29 Oct 2026 02:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 503D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cf/3KgOI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793241770; x=1824777770;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p7wqn07/dBY9IbzUhA9Uoum1J7D1mlmvbzbneoum0FM=;
  b=cf/3KgOITZLmrhCSaoT7VxXHvHZ1xN2YP3iT4xPYLh9uMXVJrmQuaQ13
   lRCI8FD2oEqcz/K2+SigHb4qAkktJgsF4KsqWov6SfkJzWdNOJyrXumEB
   0jDEOSs420+fvnB73Bz5/d0oDcLDaxt5UipIk8cnZYiQ+85vb+x2XfOZC
   kMd3ZvSoKrpCbeDQzoXScQqplwLgy5CZ/KU0Nd0DaQUNJkSTgX92v5dNw
   nCl3FxKYjZXI5OXFUPBbd9tHyZEyDyHeVEEl+6JWmwf1DrljdtdYclBqw
   r/uNbok6SiKHDqVPtaus7KfmIYCdRCJ6d8rivdQ2ABvagNtnkqfpfKUeI
   g==;
X-CSE-ConnectionGUID: 80iYJEd+SkilmzqSDamYjA==
X-CSE-MsgGUID: p+YPI975S1u7rPgd5zP2RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1860173"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1860173"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 19:42:49 -0700
X-CSE-ConnectionGUID: aD4pQeH5QeSqmYdqJuocAw==
X-CSE-MsgGUID: PXhwTu1uRS2hG7tFB9v4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5532796"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 19:42:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 19:42:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 19:42:49 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 19:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI0G5IqzKJ+xPlI1RWVLspsiH6kGTb5oyxYV2TpcVCL0da4OsAZrVGNM3TMvx7CjBEFrAYOAeHD/LwaueYIJbtE/NM0nToGMF478CHAzcMf01I33D2x+RRyygXyeQYMiXg9WpRQL2NOWI7usxYTJbh7rg5eiuicXruclZgJQEPQhrXqxT23axbVc15Mofb1OU0l6M7qH32JGF3UaISusrIhxOdyQhgKJyrDSdpZE5ViSCpcrQkRUWGckvJRgTkrqX+KDzZTaE42pEnzm4jfr08Ifyp2LpRY7B2DRlnCGLagI1p1bU1aIROCSKw/iWRnLIHk2UJu7QYz3mthYabdJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU6V5MGMmFRvxGxm1Sgtfqx/t54LbuID7smzkmEYZKA=;
 b=q+rXl6lHPyj9IexU0+R474F7iyegbEk/dEJJldcWTXuojDCQQRXowBH4pAOUZx/5FLoH92mfAyYk6h8Q79k9lODRu2rjbYgajpMWgkF7gGj2SDVYn/W6Qu8/7isDq1xMpxCjzKqdjJUhR3crYrwde+gNszvYFM2m541p/uvkKrLyPPp2zkQzch5+mn2Ud+EUhZdSpPTn4VGLrLi1H7cEL8ep8RL5fVFQdIcggUsfE9Xsa6UswPFfqD5fqCIcyCutKRwd4hhCL6umE9GtpZkILbvN11saz8ZmMWVHVVicnhiFSuxTjqOCTBkGrLMR3XjI3xA9wV59LyppO8nXiZAfZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 02:42:39 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 02:42:38 +0000
Message-ID: <1d1e0292-deeb-4df8-ba56-a4a5d527852e@intel.com>
Date: Wed, 28 Oct 2026 19:42:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/28] KVM: VMX: Set FRED MSR intercepts
Content-Language: en-US
To: Binbin Wu <binbin.wu@linux.intel.com>, <kvm@vger.kernel.org>,
	<x86@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Xin Li
	<xin@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>, David Woodhouse
	<dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>, Zhao Liu
	<zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>, David Matlack
	<dmatlack@google.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-9-sohil.mehta@intel.com>
 <c596a758-2440-4a30-b124-07f9b978d05e@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <c596a758-2440-4a30-b124-07f9b978d05e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To CY8PR11MB7846.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|DS4PPF0BAC23327:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8e2103-c55c-4c88-37df-08df35664bc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|22082099003|6133799003|18002099003|3023799007|261028144727099003|261026140227099003|4143699003|11063799006|10067099003|261009223027099003|56012099006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: GInncdYKO+t3l6SmDrBWURmf1ujGgtw2HJanq5QAx0fVA9J/wf3fIqrdj/ecPtpa7au6VewZCSUc3dlxjtoQninsXbERqUFYXgh2+BzaIe4UKwGa1n6JsG9Lprw7iVnUSIziZQlMPhyT3MbaM2xshnsdb+Q7sswvw2CjSIKJpAHaiwRtb7Z9rlrijnpioRP5lUJ+f5LsX+qaSddGoDR/Nnnkae/dUFNvyELJsfvGqITnstLzbl7L6FcNLLorT0hFVuyMMBUr+kazWpGOfLahxAN+zLVbHXPfMgq13AB2/d8xS7GqXcJGbhDoXMSr1XCAi/Z4nZe7hUlohG3y9vzGCGm/iqFzEnob6wVDU8XuCHmWdJgZFA3wg6I5H8mPSLeXIIQWRLUUEgousckBsCV6AvWK2CunC6jgsVmx1fB9OWEjAQaVMuASGG3V4dQxYlproMJY2KZRc/AkFbELemZPqK8xu+gPbnTmJuiejZKZjAppAwRqSKuSOGr2wWR1kIKF250tvWys3nokp/fLwzcDzCq8pulJ0vK4Un3OHAR33Kg583iDWMUkSlfsrmxJPJVBiMW/pInufAdndrdi2gML12bEQB7DPSysO9yMkfVr2dWvtwC7lbtTbtAcvW/yHF3nX2Ot2a4UKr7H1jwrfp0Kdzn7FCpWKO2tfO9Zhoo9VFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(22082099003)(6133799003)(18002099003)(3023799007)(261028144727099003)(261026140227099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjQ3d0FTQkE3cE80Nm1iOXdFZkJXY21vUnc4ZHJWMlpBanptR3JpclozdEho?=
 =?utf-8?B?azRWM3VjT3B5bzBMZHFVNHE2dG5Ic253MExhTTNPbzNYUFMvbkpoL2FHRXZ1?=
 =?utf-8?B?b3c2OTlZOFJ1ZGZlTXUyeVNXZnRnRFNIcUFEVUFPRHVyZS9xNEwxakczVXlF?=
 =?utf-8?B?MGVjUTc3YjR1VHR0bzVkZy8xSjRVcmRRMUFGUzZMaUJhYk1lOVdmV2RzSHRJ?=
 =?utf-8?B?M08zRXI0c0ZnTVkyUUNNU2Vta3lvS3QxQU05VUNkejdmWG00R1ROTmVCL0g0?=
 =?utf-8?B?Zk9WUDl2U2F6d3V6OEp0dEV0dUJDTllrY0VLUit3VXV6WGZJRlJhMmlRWnJp?=
 =?utf-8?B?cHJqWFB6WkhCWTNtbkpGd2NiYWE4eVJZQWpZTUZERXpFYWM1L0VvYmxCQmdD?=
 =?utf-8?B?WXcvak1idWVMaGFCcHNXRHdpMUU4a3dXUW1qcU1lSUwvNENWdm9ONkcvYXls?=
 =?utf-8?B?UEVvdVlaVUJDclo0cE1OUHNyUUlHdHJUQTg4R3FyUmwyTElOdWIwMlJhUUlG?=
 =?utf-8?B?VEs5UDNWdE12SnRwdTg5ZFVrTnlxV011dTJSSEdPUWYzcUd4NHI3em5mZEtY?=
 =?utf-8?B?a1F1N25pKzlKMlVIb1NNMm84TmlGTkhPZXo4WkU1SmxrM1ozbnUwdERadmho?=
 =?utf-8?B?QXhWU0F6Z0ZXdWRDYVpLQjdna0ZlWjhqWnI4bWNVTGdrSGMvSVZNTkYxRmxI?=
 =?utf-8?B?QTR1aDVxZkNDbDNWZTF5UnhTVDlTQUZqWGF0OTlpeTNrOGhoNGVNK3Fibk5h?=
 =?utf-8?B?dEo5VkFpTkcyQVhZUWorTS9TWjdRMmg5V0xkYmNQTEpxdHFVeTVaRHBjR1NC?=
 =?utf-8?B?c3d0M1QzS2RaSnJHRkVrY1BRM0pJR0tWTk1JYjk4UmI0VXh6SWF2UEJmYSt2?=
 =?utf-8?B?NXJ4YWcvZXVnY1Q2dEpBQlJkZmNyVklqcDZ0SXA2NXJyWGliOVNEcHFhNUJF?=
 =?utf-8?B?bDI0NzllVTJHSkxuMlA1MGpJcnVqQXhZRDdCdG5CQ1JhTDJWQ3NSR0FkRmR4?=
 =?utf-8?B?SkViZGRuNE1zaE9JWDhmOUxJUkZ3L1FyUXBaOFBoaHE4TS9zYXBidEZkSEd6?=
 =?utf-8?B?dGp3S04rRk8wZTkvZGk0OGQySklNT0hmb0dLQ1JtVFFZUE9KVHBSNWRMZzht?=
 =?utf-8?B?M2pUVXU5Mk5WVjREWWY1clRxcmEzVkxJVFJaZHBjR2pxNStWY0JXZUhlREJa?=
 =?utf-8?B?NktLWlk5MHJPYlRESS91YU9maUFyU3pNQituSlYvNnFsaWdnbE5QRFBGcXFR?=
 =?utf-8?B?S3VDSEI3UGE5NjkvZytUUW1aNWdyRCtLY2xZVlNEWDNrbWg2bXVHekpsVldo?=
 =?utf-8?B?UVpqN0FMb0JHSkRLVllySlJFTUR5U1ViTlo4YUVpN3NuUytqSXdSMmFYLzc0?=
 =?utf-8?B?MmI3R09FREh0VnkxOWZiUkFKa2dFVjBXV2E1UG92U1BWMmM3bHprcDJSeEpU?=
 =?utf-8?B?YTZUajluNk83MVp0a1orblJJSDFJNVlnR2l6NTJZQVBlb2ZDQkYwZTQrOWhV?=
 =?utf-8?B?L0VZekhmM3pyYi96MVcyWlV4SGZhRHhNWXVqbk9hMUVVN3BjRktHcWUwWHFr?=
 =?utf-8?B?Snp3ZWw1cittZVIzWStBbTdYdXZhU0tJeFFBUGs2U0s0ODg3Z3htM0x1TW0r?=
 =?utf-8?B?UW9reGFXRUZzbTRUQUpBK2ZnK0graXVqdXVmSlUweXBpQjlzRjJGN05zdVVK?=
 =?utf-8?B?MnU3a0FoM2FMYTZrUTQyb3RKVGloWklUVjFIdDg1UjNqeDIrRGtDNUN3YVR2?=
 =?utf-8?B?aHp0MTNZWDlERjhtVzFTVjVPenNKeXlldTIxYm9ReFlEQzZCT3pSWVdHaUw4?=
 =?utf-8?B?ajNNRHJFVlgxMlZzUGV5czlBVnJ0dk5nZUVybVdTUVIrM1BFc2lPaHB3aHB3?=
 =?utf-8?B?V3Q1VEhPVTV5dEtzTTIwZlRtNTlHVnZKRmhEd0VWZ3NkRTVwdDErWUlLVEk4?=
 =?utf-8?B?NmYzNnBWYmxSK0JzMVcvWC9YckZRdENJemozajlCOFJWZlFmSHB6aHJGYnlq?=
 =?utf-8?B?TVBGK2ltTm9FU3pxOVR4Uk82RCtvVWhIaThYd21HVDZqQ0ZVNHJsNG11a2hr?=
 =?utf-8?B?VnMxLzdoTkp0RDJCMjdUT3pxQ0NjU3lweUgxd1FGNTU0a3ZKNTk5N3k0cUNO?=
 =?utf-8?B?NksxeU0vZ3dienBpeTFKMHVQU3dkQzZVVUpBUTU3UEpWVVZJQUo3WmhRUEhP?=
 =?utf-8?B?ZXpPeDFtS3pCWUU1UGtaT045L1cxQzhNQ0IxMmRHVmJZTXI4elVGVXo3NHhp?=
 =?utf-8?B?NEQ0WlFKZEpFa2w5VHZiSFFUeEViNmZxQ3ZtWTl5M3RWQmZTNVFIWVpxVVZ2?=
 =?utf-8?B?SEY3cHRvZHlrUjdUWGpLT0V6NWhqN1VsMWpkM0tFdlYwZTdDSW9zZz09?=
X-Exchange-RoutingPolicyChecked: OdEV5qTxRgnfPm0AMTcEXuZeF7GISt1NhTB2n8+qJZPYzIulgQrttx4/Ncu7uv4sC0ukTV5HhMFz239CaPO6FHCuwIi46i59MZlFZJbKhuzih3IVaBwHtcKJn1nMZKml7Qvz6rsamEdeeKhWWL0gf8TWoocClJwf5dHbq9ulr1UvwoL3aomL5F1JKpl4JcT/9dqUaQpJWH5z5Zj8BhomEQnFh4kmxUXb78SCSb4yvGBD+6BUnaUNG2Mu7fa82wpk4mNfmGjuf4wmmO729V72QpuHsSgiLPu684gfzbAeNHglzDbFcTc+wGRhIxLHxxrwfRytvGm859joU85a5c210w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8e2103-c55c-4c88-37df-08df35664bc1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 02:42:38.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWoCPODfmVG229LfkuCr24sh9shvBHhvWFBvoBWJd7uUbWH0iyt2J7WHzwpprZc4ARflD8njvuMHrHpi/zOYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327
X-OriginatorOrg: intel.com

On 10/23/2026 1:07 AM, Binbin Wu wrote:

>> Consequently, passing these MSRs through to the guest would only add
>                   ^
> "passing" or "intercepting"?

Yup, it's a typo. I had it on my list of fixes already :)


>> +static void vmx_set_intercept_for_fred_msr(struct kvm_vcpu *vcpu)
> 
> Nit:
> Maybe follow the name of the function above, i.e. vmx_recalc_xxx_intercepts().
> vmx_recalc_fred_msr_intercepts()?
> 

Sure, I'll change it to make it consistent.

>> +{
>> +	bool intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_FRED);
> 
> This assignment could be moved after the check below.
> 

The compiler should take care of it automatically, right? I think it's a
style preference that saves a line. Other functions such as
vmx_recalc_pmu_msr_intercepts() follow a similar pattern. I would prefer
to leave this as-is unless you have a strong preference.

>> +
>> +	if (!kvm_cpu_cap_has(X86_FEATURE_FRED))
>> +		return;
>> +
>> +	/*
>> +	 * Because the following eight FRED MSRs,
>> +	 * 	MSR_IA32_FRED_RSP[123], MSR_IA32_FRED_STKLVLS,
>> +	 * 	MSR_IA32_FRED_SSP[123], MSR_IA32_FRED_CONFIG,
>> +	 * are used by the kernel itself to take an exception at any time, they
>> +	 * should be context-switched by Intel VT-x automatically in order to
>> +	 * preserve the FRED architectural invariant that there should NEVER be
>> +	 * a "gap" during which it is unsafe to take an exception.
>> +	 *
>> +	 * KVM leverages Intel VT-x hardware to automatically context switch the
>> +	 * eight FRED MSRs using:
>> +	 *
>> +	 *   1) Dedicated host and guest VMCS fields for each MSR.
>> +	 *
>> +	 *   2) VM-entry/exit controls to manage the automated loading and saving
>> +	 *      of the eight FRED MSRs.
>> +	 *
>> +	 * Consequently, passing these MSRs through to the guest would only add
>                            ^
> Ditto.> +	 * unnecessary handling code without benefit.
>> +	 */
> 
> 
> I am not sure whether it needs to repeats the changelog almost the same description.
> But I see the version history mentions it was suggested by Dave and Chao?
> 
> Can this be just a summary instead?
> 

I will try to shorten this one and the next paragraph a bit.  But RSP0
treatment can be confusing to a first time reader so it makes sense to
explain it in code as well. The next paragraph also has wording that
makes more sense in the changelog ".. so no change is needed to the
interception logic.. "


>> +	/*
>> +	 * MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) are
>> +	 * designed for event delivery while executing in userspace.  Since KVM
>> +	 * operates entirely in kernel mode (CPL is always 0 after any VM exit),
>> +	 * it can safely retain and operate with guest-defined values for these
>> +	 * MSRs.
>> +	 *
>> +	 * Disabling interception of the two MSRs offers two advantages:
>> +	 *   1) Simplicity: Eliminates dedicated MSR handling code.
>> +	 *   2) Performance: Avoids frequent VM-exits since the two MSRs are
>> +	 *      per user thread variables and frequently accessed.
>> +	 *
>> +	 * MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) is part of CET supervisor
>> +	 * state, but all four FRED SSP MSRs are architecturally visible on any
>> +	 * processor that enumerates FRED.  Even if CET is absent, these MSRs
>> +	 * remain accessible via RDMSR/WRMSR, though FRED transitions will not
>> +	 * use them.
>> +	 *
>> +	 * Intercept MSR_IA32_PL0_SSP if CET shadow stacks are unsupported (even
>> +	 * with FRED present).  Since this MSR is rarely accessed and ignored by
>> +	 * XSAVES in this configuration, interception avoids the overhead of
>> +	 * manually context switching the hardware MSR during vcpu_load/put.
>> +	 *
>> +	 * This behavior is consistent with the current setup in
>> +	 * vmx_recalc_msr_intercepts(), so no change is needed to the interception
>> +	 * logic for MSR_IA32_PL0_SSP.
>> +	 */
