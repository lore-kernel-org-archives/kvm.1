Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31923ACA5B;
	Wed,  1 Apr 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032070; cv=fail; b=OvEE3j6+yHB//7kKMulsfQUgy29tDc8GutvOwDm53SmRYHoIiFGEZDcBQyWCOUiwhviLpAl9ad+IVTjXWPQSawoWwsb8wh83s/cwUsEIOpqW3lXB2eDNx7cRqYyoNwdVTQ+3E486IbOieAVPe818pekUHQ+hMZoktQmApJufZbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032070; c=relaxed/simple;
	bh=2wAnYMzbfQ3SFP1/QvdOfBGDmZeVOTrUbPEPeIGc+ak=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NauGq86kORrBwdjaCN8Gzu4k16boS65PldnHNpnd3Lpwq81bJP2kUdzPv7JcI5Audo3Fi+r92dE4aWOMDs0L+OWutK1heepUSPQ011co17MmZueyPMAXaU16c+x95t5M4zidyv4YLxaogPR4OG6mYq3W0XmJQldUAwvz0EjRwNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QaLdouQk; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QaLdouQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775032069; x=1806568069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2wAnYMzbfQ3SFP1/QvdOfBGDmZeVOTrUbPEPeIGc+ak=;
  b=QaLdouQkPSpQAjCPi/t84VmD3rcF88WKJGt7Ni/tt8uwbl/yRVb9X9PC
   dk5h8g2mpSkWpkQMtutkm7lJ0iDRmZbLFuHcqVvve8PL/xl74EZQASq2c
   CpSeb3Wj5zhBKPe9ikuZdYKoGHcHEwIB7/b9lonOi1oip1CRrOJospZRi
   xc+HrzeFiNKexfYVUj5ynC0n1chYCyos7nFwUjrAiyMNGnTycAkDodaz0
   VJdIIHopWlm+hCD2TF2GiNvv79nxDu+2/85wi/Li24pOdMuK3xTtlmsfx
   mao1HmPV8Tg56isdg9JXl+en3s83Z1syH9eLIq0oD2BsZkOD2unDg6FEK
   A==;
X-CSE-ConnectionGUID: xmZmblvUSbqR7zoDRzGDwg==
X-CSE-MsgGUID: wmHSVDbmSYCTHp3p/AkPLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78655817"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78655817"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:27:48 -0700
X-CSE-ConnectionGUID: 6xMyDX2ST6i2k7uk9jnlCQ==
X-CSE-MsgGUID: DUn4c7ihRuyeB1Nky/YSDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="221757619"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 01:27:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:27:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 01:27:47 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 01:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIC+Y5ry5L4fecAG4hIR3oCXDyOVvvHO7Fsl9hYfJ07272NVTVbmv5qcswArInnoVLayFixVTCfFJlwzGNntI8047teiBJsk+zhgXn+NSC4pY4aXQgh0CkH1QAiP/UN/z6pKijMZgMPSWuV/wC6uglc85GF5DzGv1Woa6B+kfIzz2tRVyDFHPdsAKZw2+WWeGoBkTQq7zwuv2cbAAbsFb2A2wRczQD3RQ76IVDNRVaR8D6G1+4HsabwewdT5+CyupImAQ8z1PJFl/Xb3roVpdDy4e9PImEBZs/eHxrlg8YdUDx6eNywMIbEONS0aewdRglKxPJ28+XFI0kUjrmNEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dixu3HiCQt9iElzxi2G3mft81uVPeNwZw2BkDu82Rs=;
 b=J/LNvFqrhw9U4i0NRVw/qyVBeYDARY3lKwH9/38UVhGkQ+UlhN4wmYzsX6EMqvGRDxi/HEV87YNssxTKbScJ2z/QlTwOP5Gp37lkugHt4sascIgVZN70/94aaNBl7yis/9hhRleJBVlLoLMxgjw6E8c4T75VFLT7PFjj+NanowBbMqAN1hZI4NFbxIR6I3jlIjF6or56Jywbe2ya1l5bwsEqBjVxOlBVKdq/KsbU50ToivhxUEEuDn4wqZ4i8M27GWkBRBogco/2ZC9i1I1nW3sX0PDCjJd4aPq8I2z8GcCegKEueDeThzcaoNz0fO/zp6gBa53hmVrPESapmqCKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 08:27:36 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 08:27:36 +0000
Date: Wed, 1 Apr 2026 16:27:24 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <kas@kernel.org>,
	<nik.borisov@suse.com>, <paulmck@kernel.org>, <pbonzini@redhat.com>,
	<reinette.chatre@intel.com>, <rick.p.edgecombe@intel.com>,
	<sagis@google.com>, <seanjc@google.com>, <tony.lindgren@linux.intel.com>,
	<vannapurve@google.com>, <vishal.l.verma@intel.com>,
	<yilun.xu@linux.intel.com>, <xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <aczW7MZBqsCXw4gk@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-9-chao.gao@intel.com>
 <6bec316e-3216-425c-89e2-fcf32fd4e15a@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6bec316e-3216-425c-89e2-fcf32fd4e15a@intel.com>
X-ClientProxiedBy: TPYP295CA0054.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::6)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f54a7a3-42ac-4c16-bff3-08de8fc88750
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0CngzCpVoM8veQtHxXZIwUcltyh3jeYHSic5m1k7MuUI056RCEZp/XiWy0PBvVK9ZytyrV5Ts7wvxeYHXG2hfshxkU3P6oMBA+qYmn34kJ3jeanfLjPluN0FqeebeECjSOv3/itTqwnfyP/Uobpf1Yni7V1rEkM0oQBob6ulWyeLFa0JxqVsGZgX4pMrsGHxYsRJXqKuszwNQEUx4CWysZrXP8zyybWRcjB7xGxnWHd/MfoB+s/Ut+dEzILEZx7RHtpBmdat1tbjUt1PAvaseUtUI+JYE0Qbpzw8DM2dQjf2Cg8uiftgHsCezeAs5MmT7gxqSQIZvQoJqaBhXS4V5uh0tegjmqZlUk/hQ699/3mZvCJkQMEMi2QYH3biCzNgyNW3kG+EmxNzu3xmlskZj3Y0/p+Bwh/vMmALU+C/xxQeTeJrajoD4diyTAxfsUwRAva4kt60VH/0H7Uytah24RGJKifeAg8g9fEqTZlFQYfrq3HH8YbLqi0f19C0h74zG7QngEIOM3Z67OWrhGyOIOq0QynH1ixoybtQ2ESKtW5VfLYbbPcX8iSAc42m0doO6VSdcCY8EAY4AKlFgGnYfHBTAHiJNve8/3Sbqla0/+6buFWrvLDqFKjqj8f6Ilbaef4JYbLDUKerWsqT7biZ9xNnLTrfHFZjMzdGDa2rBvD2VBDZWTzj/pQ3hIw5M/bqW4+iY9HhLbwtwLB7CfCGpUFVaguJa8PCIRdPq8gtcg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFRlsVw+FipLbcSw/X7dfYgEITo3sCqpUGPnbBUWhVknMH3z+rBR66j4K1ms?=
 =?us-ascii?Q?lTWRchvnMDatiuXu9/o33XbOlqpGKMjuRIBICk8A6MvdrHsTHS8u2mMxe+nD?=
 =?us-ascii?Q?UoyWzXL30docVfp2nWIFij7yGnwcSu9cl0nWeByCXWVQHXqmRrW+eJdyiVfa?=
 =?us-ascii?Q?eqUwtxoLsAM8EUSdJqJV9U+CJUBa6OPoLcvKG4cejc3nAhHmOzPbhCsrh4AA?=
 =?us-ascii?Q?VQMUYpv08Rr0d8CiWCyYMLAMDig+IvH+cTWVraFNzTixrFk5QLdkxmW8BEiO?=
 =?us-ascii?Q?XAUB1yooS0zsloMrWhjLgMiDuI5oiCs4vsMNK/ixxrvTmfb3tfIhQ//5ZSOt?=
 =?us-ascii?Q?W6bMyLIDeYpJ6paKuUEx4Y2UtdFFHtl/qh+nxTLACH4AXAQ8NyE776wqf3gT?=
 =?us-ascii?Q?HDtDLMXGQ9l4QFrUyTGVekdQ0SPRLHfCRviiFvkcMkmD1/dtfJxDyRj/WjRB?=
 =?us-ascii?Q?n4DhuXB/qXgSttdMB2l1NQnODRbLvV2Z//+pyL+vnJALw9wkGWs6w3MXqMu0?=
 =?us-ascii?Q?SxX67s12ytCjFtUR2ZSGAt2ksf58JIqLL2or68hgMeuPxl8VfkBkwL8B9PAr?=
 =?us-ascii?Q?AUyzdiRBb2SHsNDaTtUYuqQwlb0fk8+4OPtdSnbOeurmoTraDpEjvrvq9FYx?=
 =?us-ascii?Q?2jZuw0DpfUHDf42eIRJhUiosTOYOD491O3ke8mLpLcPXmjajs6HeqON8bT2R?=
 =?us-ascii?Q?ymETuFJcCNwzl5yYgUm0SEH1wfHXRRrMiXrwX6udgoXdxo1gNIQacFuCKXji?=
 =?us-ascii?Q?ONjuRO/PXqIyfrIeBqs74ydThT0GQwg22rmfZp00CUAq1JVgCnyimJ8zI9jJ?=
 =?us-ascii?Q?krN44KofFPrY6X9XD1gdHTsHrUZhv7AihlLqhec7aeohE63XGXZbqInIJN/O?=
 =?us-ascii?Q?9oi+CY2DLjT2xPb6pW+sFpN92XgfU7mVbdRNcH9D3ha85BS+AGGy4I+0Z+h9?=
 =?us-ascii?Q?CJJuSfhNHQN+GjbnqSdOtf1lZSEmBGXsmzU3/T/4EoYg60Sr0qa/LclQEZ08?=
 =?us-ascii?Q?qcdUcLTLZP1/XK1k6A8V3cSuWTIIxdC+c52+Y+N6xLSkwukDLzTPWDX/aAtl?=
 =?us-ascii?Q?+CIS45Ua2KqzY4q2il0RMYlNsDhoovhqARuieQGmpnkFJCvJ7pRPFMqspieV?=
 =?us-ascii?Q?27wcBqb4SP/8TiFvK8+UsZSqCULt8Il1Wgtfw2ChdJlRwrSf13gXEnxuUTDx?=
 =?us-ascii?Q?slk6Jwu7qZMWCc7+eDIzEsVYCRn0c45T/sxVr8ZoY8n0XOIcr4egxUhCM6OG?=
 =?us-ascii?Q?KJOvxQMD+ja9ubOghTichohuTAONU3WWY3k3kc3tWrGiTWqLsPXVFNaOYy+0?=
 =?us-ascii?Q?cPGQJ96p+PfZPgM34l4yfnn2sNwhGgbuR4fofWyYyh9NKEF+75RQd7WkZ6VI?=
 =?us-ascii?Q?2eRspOZceii2F9pZKkHL+66NA4PB+fqtEXbMeWeJWU1xg1uRFNrIZcXp4yTq?=
 =?us-ascii?Q?Ev3vOOyAmD9n7od5DEOrbrl17u4BGVndAcHy565jXJbOLiPvlnYJLyxywJNz?=
 =?us-ascii?Q?+LsESTZr9K9KskctXkDJolxGLfHZvhcyS4csMMWwOzQ1NdHHHejGVLK1ZrcI?=
 =?us-ascii?Q?aFjL/HdUaks2buHArxo2CQBLX0FRCRXqgJfK98BXGqTcXvAhub6B/K3xdthu?=
 =?us-ascii?Q?M6THJcLCx/0bZ5Pc7wTitMSneF+jCROw4NSPYXjkeZAU2a1D/kHZue07Zhu9?=
 =?us-ascii?Q?XOQ5UxIe5nT/IUHxjgKsbk3eJZVgqHpQlYessHskosY+gMPbcujVnemDXC/Q?=
 =?us-ascii?Q?rcGLYdchUw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Nn1yZyGR69s0LoVcf/OU9BLl293N6T6dJylwllCJuvvUFWMDHRPe6Q/dxOn5HNHhCeFnezX9TsLYmCqQoaeHv9uKcNdTi9T/y6tjW469xej86APopEZTUqA/JWltK7fMYGdk79+vDmf0qBO9cMPFkbm0vYgNHx0JrlZvOMFG8EdExAZW6cf7KBLXmx9+XNBa+IdDBMcvSaIth/1sGd1lwu83GNIRZr10lWndo0zSK0xnMSbNN9qSEy2wUWI5ZK+oJd9scyxanfhM3WlTx6WYwJcx2gpueYI7d/MJwia3pBGLosTqbfNtz22bE+Hxf1BRl16KCyFmsqLmhzDemCpf+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f54a7a3-42ac-4c16-bff3-08de8fc88750
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 08:27:36.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJgZaemP94A9Aqr/7UtnHbCZ+DqYGILEFYlnk3YxQjiF/Y3bJ+3Byrd+WkX3lDr3OnHbleCuucbIWyx0rwLUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 08:44:36AM -0700, Dave Hansen wrote:
>On 3/31/26 05:41, Chao Gao wrote:
>> +	ptr = sig;
>> +	for (i = 0; i < sig_size / SZ_4K; i++) {
>> +		/*
>> +		 * @sig is 4KB-aligned, but that does not imply PAGE_SIZE
>> +		 * alignment when PAGE_SIZE != SZ_4K. Always include the
>> +		 * in-page offset.
>> +		 */
>> +		params->sigstruct_pa[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
>> +					  ((unsigned long)ptr & ~PAGE_MASK);
>> +		ptr += SZ_4K;
>> +	}
>
>There are a billion things the mainline kernel _could_ do. Like a 32-bit
>4/4 split or a non-4k PAGE_SIZE on x86. But the mainline kernel doesn't
>*do* this.
>
>Why add complexity to deal with something that doesn't exist?

The intent was to avoid sprinkling subtle assumptions that PAGE_SIZE == SZ_4K.
But I agree that on x86 that's not a realistic concern today. I will just
assume 4KB page size.

And I assume we don't need WARN_ON_ONCE(PAGE_SIZE != SZ_4K) since this is
unlikely to break soon and shouldn't be very hard to debug and fix if it
does.
