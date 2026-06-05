Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBF76026;
	Fri,  5 Jun 2026 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638049; cv=fail; b=PRRdaYTLtIYbta8OM+sQTkNwr2p3za2nBeL/MQUsZJUCG4UTmtczVxBKhv1MREbH2pCxalleKxy93sdtbfKRALbqW2lR3tymPwRGFynS4uzEStPtksgHzW8djaArreRohdXI8Vyr9qcRhuT2o8C4y4AI0Uagd6NsnmXAoWljah4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638049; c=relaxed/simple;
	bh=zMBoDNt1jcXsEFj1tfBJPWjJn6/Ixy5JVrRDU7Ll4mM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kbnz3yocxFBZck56cnbvehuPCP4cYtPd/ZRqo5wTrQQfy42iQ1qd+6c/RZM8uIRfScbHpDQ2kDhsJX0Gt3bnBkrJTzoIiQW3IJLtXqP683YigW4xNj8WBkIkXp6KcMaGUro06ief7y5X/eWU9TT7EGOi2v+9PuoebjAFJTWyAE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcS7zC4K; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcS7zC4K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780638048; x=1812174048;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zMBoDNt1jcXsEFj1tfBJPWjJn6/Ixy5JVrRDU7Ll4mM=;
  b=OcS7zC4Kbqw4l/hHH3hOTsxOVV08SjH/XS9/Qrng5DcHhoKA62zDQH4t
   dNo5Jh8B2hypnaepUH7U7dGMzzUqODqk3jz5RdXXLg9JOOquOhp/YCI8O
   3TdHvbN5QWg9Uec+xpekuq9rfZ9h9Rf64Yvcjmn7y1uZFh6hz+pX20HAp
   0E0XYio9n9SSj/+D14FmGu4blhhnGX+moCmHu6NqDKIUdIQ1hVV4XxQnU
   vxTc37u/6rkNOkr+ldqN361Gf7enj7VASqpMq8EGtj8kSxEP5B3H1URW3
   SK3rnL65zNA2lOUUqKixSFKWX0WN+uXP+jcph0MRApToe+FUf7oFsM1Yf
   Q==;
X-CSE-ConnectionGUID: VZfV2ZbzS6WvDlQHOEh9mQ==
X-CSE-MsgGUID: OdacINjdSAm5AaPGuffZ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85322859"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85322859"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:40:47 -0700
X-CSE-ConnectionGUID: 4uD/g6zuR7CSNWQ0dZKsXw==
X-CSE-MsgGUID: KoyoB7AOSYOKLOd9414bGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243668989"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:40:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:40:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 22:40:47 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTx9X/IH+1P5E0zZ6McziQol3aP5zOkEdLBg5QRunJawN5/ONRtWQOldsvc0/Y/w3K/LWDYVqidpvvPOFz9Ljw/FyViloAA36IkU04yYi/H2LJgtyUdMa/gKlJ9DPU6PkODSd4hbrkhmzmtlojXIiAHWV5QsAhCzgsiRRHNUdBuskbAmODlS3ENaVXF+IAWDaC4xhZno9LKwBAGzlXTHFd5saw5iRtYLzZHg6LGXUKtx42a8RUXj+Nzzx0VNQz6zWWlSY6BouUeImMYhFQAOwxwgJQrvb/XStRUIx6g+thxrmegYUAfxfFMBKxQmRlF/mEaQpCDjOECwrOOuxxLQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVSc01Xk1W8nKzzFaAic++sap1vKPRhAdzwnHMQILxY=;
 b=bQthjn69EvEMI98ierA89RLIGnqHk+nkU/3oh6dLu5S02ZePmlvMBcDHUEB2fLxQdkwOgJyRvlgD3qGyq5RO7R5rr6quki6DjECJwf+mZLALo8mO3Hq8RrB7mWoH+d2gno5dBYIzJuaE3gbM1lAcodOugSxrN9/VGbW4O/JI8SPrkkwjSe16Fs2RzYMv4fZa/ByDLnfZlEPsmViEFcm3Cw2bJ36/c0BCjTqBOTIBle5sMAKeGvbtwAQphfmFj3qG6Rsd4B1RA8SXZzcgaccbh1jM/OozYbs3u7KnAbhcubTrhzfSpUeTQB9VTKiwC75CqJAbYT5sgQDfQ3H8P4r8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2836.namprd11.prod.outlook.com (2603:10b6:406:ad::26)
 by CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 05:40:38 +0000
Received: from BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b]) by BN7PR11MB2836.namprd11.prod.outlook.com
 ([fe80::ac36:7540:4e6f:8d3b%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 05:40:37 +0000
Date: Fri, 5 Jun 2026 13:40:25 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
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
Message-ID: <aiJhScChLZkH44eB@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
 <ahVghgNAe4JrmlQH@intel.com>
 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
 <aiGq7XjmMrsqdBY5@thinkstation>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiGq7XjmMrsqdBY5@thinkstation>
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To BN7PR11MB2836.namprd11.prod.outlook.com
 (2603:10b6:406:ad::26)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2836:EE_|CY8PR11MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ede19f-a746-43de-3859-08dec2c4f8c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 2kXxm44LGspNppDABok5K+oWX2PM+qcYFWHfQKgHNUgilX12M+wSReT7gm2Un0YKwv7CXF+190FLDOr95JoKc1YHSPdUJBb/4gWh5OBRYrd7tF9GWz2e5a/js5QuZMiwyx8/6T2FvmXPoOl00Ek1ApfVnGdXaWv2v/61O2iWCggI36Zc0EIFB3H4LSlS5S+78pXmJehSZ5vG5ukTmTSbTG9yg/WC+mo75Z+/L4uU+EMWkgsmBsxA9eQQTArnzAiAYdW3xyu9ka1V10rFgxi1nqjVBMb9RqO7G5Iz00C0R43km1fhgSf8TRqQMmd+JdqOMmYl4ctcc95qCEiI3z+B2pEqiho7veZycNYTMMZd8nueGVvtdvHmRei5VHLVmTsK93AKwxEPT+FyiXlA1L05yV3JOOV/K1HYxQ4bp+IotaxKMJ1QN1mcG++GtfY4JwLE3KzsvO89dLmRjnpAjMspvggOvTqzK8Agtro7Z4oUVSlw6N3S4UlxxOisFNW7QKjltKIXnylnNcTvFfkuXM1GF39IsdkMYz2thxfQj+YD2gheHzeCGMSOYkaAO1xZnBcF3+GrYvBPknP+JnMOrGn81VwrdOzSEqG1Ujlj4gaUBJZcYcfdTl7mCjlFG1xxFNx+5SRWxK3/rB0Y4B94/f/GL/UXe3gglAPMITwnPvftJNVU1aaWB6NVcdhe1KAn3j1TRJfnZrGGfTwMZZY+VMx37Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2836.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUc0SkdOSU94azBXRUt5UWdpbGk1dUVVem0wdHhTNmhENnRRcG5iMXg0ZGo5?=
 =?utf-8?B?QU9FTXVOVnhTUE9iTUNqWVpqaWxxWng3bWxGcDVKQTB3RW1KY3RPTGpEcFk3?=
 =?utf-8?B?bGJaMVVDL2x4eXRsdUNrcUhld3hGeENOZWRXcGIvL3ZNazkyVHZaejFVTmtn?=
 =?utf-8?B?K3poK2JWQUR6TThyWExZaFNuN3NiNXVHb3VjNXhSRSt1YnpwWUxlTDY2dFNm?=
 =?utf-8?B?dzJnay9raTZ0Y1U3RmxhMnQwb1JuVUtsKzBqd2xIcnNQQXJUd1NvdVl1L21F?=
 =?utf-8?B?OXp6cmhoMzRhSWVOaEtSRUtZdjZRbVlSUFo4ZW9KVzkwOHJId0VoTDR5L3NT?=
 =?utf-8?B?ZmFmOVI4RTFEbEd3STZ4TTlqdUVSa3dwbzZjUzFsQ2tyOTRoTGkzTWJYWWNm?=
 =?utf-8?B?MjRwSlZoVHZ0Nm5PUlZaTmFhbXh2VG5RTVgxa0dnc1ptYnd4V3I3bHZUeXR5?=
 =?utf-8?B?Um1UYUk4aFo4Lzh3emZFdmtxT0VkRkxZZUFDR2hLejRITEpOZnhQdTdsZms1?=
 =?utf-8?B?cW03SE1lekxKRDl6MGF4ZDA1VStiVFYrTFdndk1QZzBoc3ZMelNFRVpjT3ZE?=
 =?utf-8?B?Z01BNC9FY3UvK3drK2hXb0FHQkI4aDVyd3prR09JSERjdzFTRndiT1l3WUo4?=
 =?utf-8?B?VVdHQ0tZUnQ4MzluL3lyM0lJcEJmTTBNQmlTZzdtTjlCYnM0L0t5Q1dUODdG?=
 =?utf-8?B?YjJrU1NISFFkRTczaEI5YXNWSkxLNWdZdWFTQ0VFcHlidmZUNU4zaW90SjJI?=
 =?utf-8?B?S0preUdqdFl3Q1lDYjVLODZIOHN1VG9zL0hmVG9aNGhZeHorc0t1cGpwczZ3?=
 =?utf-8?B?bi9Fd1cvYWxRSnlIWmd1VnhOYkVQWnBEN1ZOYlg3MEpUVnVKTXU4L01STlh0?=
 =?utf-8?B?YWcxeDhyc1M2ZnEwc3UySE0yWDRlaEhHVnJJQUgzNFpEZ014ZTdia1k0ZmpM?=
 =?utf-8?B?cFkzdURpL1loM00zai9SUHd6SUQvUEdrMlJ6UmI4b1VmUnRUcThrTE9PRE5r?=
 =?utf-8?B?ZXR3RlRndzV5by9FRmZHeGYyRGtFVDNsbnlic1ZibXhyQ2lYVHRLY0t5K3pC?=
 =?utf-8?B?dTZ1SnZlM3ZqVzZacFRDL1hiVm9uUFgzV2hWNGorSlM5K3BaK05ZWXNnTW9Y?=
 =?utf-8?B?NzllQjF6RGdWazJMZ1RaNnRyV1p3L3pPUmZEZTVFazQ0UCswVzdtVmgrdGJE?=
 =?utf-8?B?YzRpNkc0OWJHelFRYm1lcWdBR1Z6OFA0bXMycFQrdENoejRaRHl3dXBSc2M5?=
 =?utf-8?B?YkRDV05nTXQ2U204R1dNOVozSHE0Ny9jVmZ3RnhsUzlaaE1saENvbG9BY2lt?=
 =?utf-8?B?Y3dKb0VsNXV2dFd5aFgzODg2aDRKTmdwUUZIdFNsbzYxVW9vd3o0ZzFodU14?=
 =?utf-8?B?S0Vzamh3UmFTZHk0V3p5TU42YURqYzVDUzdiQnppWFdOUHpibVVBNmp4VEJG?=
 =?utf-8?B?aEVYTFhBOHZienRWd0p2VmJxUEh1Z3FDUlA4Qnc1MVkvM1NDSldQWU95cUhV?=
 =?utf-8?B?L2djTlNtWkhPcEEzUmhJVU0zZmd5dFIzSy9ha1AvcEFMQXJ0MlA1N1BLWVVJ?=
 =?utf-8?B?Y1FPZjdKYkZRbEFMK25uUXk3b1FQWG82WkgrY3NiS0NqY0tOb2ZRSjJ6ckU5?=
 =?utf-8?B?MDRDQ2xZZ0Z5V2FxWFcrWWxtMGpOOG9FWFNZaVNhUE5ZMDdJM0kwUFB6NU5t?=
 =?utf-8?B?ZFVnVFoyc2pmV29YMjYzMFBmU1owRERLUTdBZWNCOUVHZHNCWC9SNEZiZ2xF?=
 =?utf-8?B?c25sckRZWk04MzlJemp6eWp2YksraExEVVc4a1dHUWZqRkdZclFXOENXanN4?=
 =?utf-8?B?MEJTTkltMnlibVBzOXBxKzl0V1RPTER2MEtGYlBFcXVyMStJQUlWNVRvQ3VQ?=
 =?utf-8?B?dElxTWIxQ29uK2JraFN6dGI4S3p0RUwyRFR1Nnp5U1R6WVhnUGNycjJ3OXRK?=
 =?utf-8?B?VE5SeFk0bkJ3ZFh4UTN2RDhqSWs0L3JzME83Z1dSNll2SC9uRjFvMmtVRlJt?=
 =?utf-8?B?djM0Wnh0WXlrUnFMb0VlNEQyWldPcGgxY25vS2RMcU5HZjNsTnFab1JBZXU0?=
 =?utf-8?B?eTFvUFV2V2xVRG1SWDhmOXRtc20xclZodnh4eXJrd1N0ZjlZS1cramwvWmdP?=
 =?utf-8?B?SU9FZTN0RjRjdnhtQitzUCtNVWtWSkVCR3VXYWs1VTBFbWlmRjZSQm8wTmFX?=
 =?utf-8?B?NmJaM09rd1lybkhKR0JzQ2w0KzUwOTlhYkZFTTk4OENITCtnOTZPQzQ3aG9s?=
 =?utf-8?B?Qko3NEFsc0QzbkZ3YkptcmkvR3FBWWlONXg1a3hGK1dISG5lVGhTNTVYWnNE?=
 =?utf-8?B?REZoa3lGalZuaUx5ck5sZCt0OEU2NDFLTlhxTldCQ1gwSjdwWTRhdz09?=
X-Exchange-RoutingPolicyChecked: SsnK0Zuu5rf5jHgFLlgCUkg+YNqzMLvgCwCPlgW2cdv3W3+r+a2nTRrsmAlTeG8hInJIGFgq44ClOKV/w2sf0VRIH2Pbyz5mPzru6GWuC9RVztaLKhgrC7eYbAEh72Aw5/Zo/mGgJLXoDeLvK/wC38yrTo6pNoSggvTWRAgu1Z383h/7g5dh0peGxZ0hUSpoY/YSxkUXANP5OTxpYryXNB+pTZ06SmeLnJq1R97xIkYN4t8qeODnMNGKUqWAFh76V76dljCSxGsNzoLm9ONCZ3RHuwVEzuUzmuhIwC7BYqMVOb7EHtKLARB/BoPb1t8Q1TnT4Ue8rPc7tw33iixdGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ede19f-a746-43de-3859-08dec2c4f8c3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2836.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 05:40:37.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MikyntMjjgWNi+lyp7311uE1AT8RPfu2Do1h3YwyFQICSkkduDXcX+Lg8h0he9v2jp80PtRi0kK3cMOD4MM9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7290
X-OriginatorOrg: intel.com

On Thu, Jun 04, 2026 at 05:59:02PM +0100, Kiryl Shutsemau wrote:
>On Tue, May 26, 2026 at 04:42:24PM +0000, Edgecombe, Rick P wrote:
>> On Tue, 2026-05-26 at 16:57 +0800, Chao Gao wrote:
>> > > -	scoped_guard(spinlock, &pamt_lock) {
>> > 
>> > This converts the scoped_guard() added by the previous patch to
>> > explicit lock/unlock and goto. It would reduce code churn if the
>> > previous patch used that form directly.
>> 
>> Yea, it's a good point. I actually debated doing it, but decided not to because
>> the scoped version is cleaner for the non-optimized version. But for
>> reviewability, never doing the scoped version is probably better.
>
>I don't see a reason why we can't keep the scoped_guard() on get side.

One additional reason to drop scoped_guard() is that it mixes cleanup helpers
with goto, which is discouraged. See [*]

 :Lastly, given that the benefit of cleanup helpers is removal of “goto”, and
 :that the “goto” statement can jump between scopes, the expectation is that
 :usage of “goto” and cleanup helpers is never mixed in the same function.

Removing scoped_guard() here also reduces indentation.

*: https://www.kernel.org/doc/html/v7.1-rc6/core-api/cleanup.html

>
>On put side, we cannot get atomic_get_and_lock() semantics without
>dropping the scoped_guard().
>
>Maybe we should keep it for get?
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov
