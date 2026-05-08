Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8737BE9F;
	Fri,  8 May 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233858; cv=fail; b=bAqkPQEBufQiGmMMrbjdsLYxP0wPhFFkT8VKmwk/v99Dv0E+tFSFqCK6HQnrlNYg6YbIzf73sr/o4HhJigL8Uw04zEAt0QJwtRAkr2QYOCM9xXbW+PdYD05S6PLwMwo5ughsnL4xBTDle+jzvnVl35t2KVDgTs2n7u9GmkcWvEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233858; c=relaxed/simple;
	bh=zbYhy4KpXJFDixG+XbLRypMKDD2f3Ch0CJ5uqu/b9oA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eA2dqcaYAjvHpmZHPMcH/OYiJjNquWsCHGJUyKIY1BeliMOtbhlpY7uF0iMkRXWTGJVZj0VqM1REKmNOThCWgbxgnB+f8za47zC5wLa9iyNEGRAFYb0clTp4JEn2QQr1K7exh0AoJ5uXjTAT2CafjhoA3pi7w7bDNEVeUpO2mdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMiHaJa+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMiHaJa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778233856; x=1809769856;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zbYhy4KpXJFDixG+XbLRypMKDD2f3Ch0CJ5uqu/b9oA=;
  b=VMiHaJa+DxJW92l8LmW2A3FWIAJ8sx4+BcU7stAUrATT91S5IjCcUYFb
   QIwE71+tPWMbgACtZMKJqhAKDyQ20WAHf8L1/Up7GkJWPzeFkSUmF2UHB
   J4Q91Dlh6pX3De2qUac47Hdf2Fin1JXOHobFjV9wPDE8H9G22THXeZiP7
   YfYvTlIxKmkpuNWhXqu57d5R/hcFBe1BstLiIZiTtv3jEarCS2oBLMjh8
   v19E5rIyi58UHo1jkxi7nN2foLnGfX53wp6RokPN1Id+4FvCl9VYyEqeM
   PyD0UD9Kviw5cz33juleUk1a9urzEcC5N9Vbk9TaEC/2+tkanZ5uHzRYX
   A==;
X-CSE-ConnectionGUID: njIDGLcMQHOBMFBmAr+fmw==
X-CSE-MsgGUID: coYnR3XQTg+I4re8jD1D8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96623655"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96623655"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:50:55 -0700
X-CSE-ConnectionGUID: ZK335LcIQB6XWlv50Oe0sg==
X-CSE-MsgGUID: 18nCiuF3St6QHf++dQfeaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241728435"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:50:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:50:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:50:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdRk4cdnKBFD0Oik7fy956NkwjkBuX9IvSF6aaAzUhejVo23QZSoRKookEGmcRlCCrxZlAYikm6EjOlSPLBc/kp0Zg79DNbutRykpUzFw/PGAYDZh81e0w8uYmN549zdvK2Zc7IzP+p3+UPL84DUDNjJsDUT6za05yNOhflmy4+I4y+2QO/Ie7vsMGE5qzpmaJGyLUeANsLhc5O3saWzIxQFQYFfFv1t+/bqMILxUHnV2WIQHax0tXCMOsx3bm0btAQiBD73aRc2OieTqiePpE28Zpr9O4ZFgAw9jS2LuOqbKKNIkYSWUV1PvWXP7sSDZYwPJfwAOTosDlE0RKhPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkwMqA0uD4bzqdQfCbwBgFDNa9JkIi6QGeUDvCC0eXA=;
 b=PQ7Cvd2PdJS9jbZ6PUUg6dHWbTWS0t9//seQOZd7AoAxQ84UOWPfIlmaDmhqjIa8GqoV+1iDb09dds73gHMjg5wHOcrtq4CxrUW3CrSoi3LbUojFYNVFSEgU5cX6sbKx0DkUJGyvDlck0NOc5Iy8KnMg0fchocBzukEOZm+1gPu4wzYhVDJAwagTncBDU1Y9dylszqjOiaPN4r7gEJ8aS1sg07DpcttQyJqvVqpKtJCXaqqQ6rOkbtRT05M783LYWhwuDhL/xjNCBpWXwsikswErzmixkHx6yoMAmoYnOxcTVJwszQHvnmtFgZOY2kfBJes+JYD3iHYwMKI0ie802Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB9769.namprd11.prod.outlook.com (2603:10b6:510:3a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 09:50:51 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 09:50:51 +0000
Date: Fri, 8 May 2026 17:50:39 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<binbin.wu@linux.intel.com>, <dave.hansen@linux.intel.com>,
	<djbw@kernel.org>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v8 18/21] coco/tdx-host: Don't expose P-SEAMLDR features
 on CPUs with erratum
Message-ID: <af2x7yRMx3lXQL06@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-19-chao.gao@intel.com>
 <abd48a30-8d51-4a86-b662-b09afb567dc5@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abd48a30-8d51-4a86-b662-b09afb567dc5@intel.com>
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e41b6a-38a7-46e8-461d-08deace749eb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: cxTsHwtH6R8mCnvQNgeZToYlDPHQnfCFQ6nmNTKdVjIZ8O5evxzhkaGIPFNFg6wYDiCif4UyKA1+BcC6ESJVr3KWqqEwKMCytvLG/PQD4A455XgzHzeZAqXHngyOAFPfC81nwGW/8+JLmaHo7leyBeiMrc+9JFa4DojCnEgaLL2LQvAvtx3RpFuUfs8oLtIvhY8Uzz7Euunh8KRJDNUNsW2C3AB2zp8JMc56FeLfsLbhSwhz/39F5MQYgqL9jiexmspaA32A/xRrNct5QWT5kFN7QPSVUAz3fdsYSU77uOyEh5o1oe71sU5nR+Ac6A+SVljb7Mp35buBDzAUCwCiL2dUz5jo+FE2I59ZWU3b/8ZwSvE/j2hmZBjHRA3/TzbMV/rPiXD4O7xEhTO5ihtkfXIxGQas4vWuSAZgKUvzmcikqUCNqFvAqyboKig7VpUm2l7xfti2N+81DSTOvhTyDU+STCwKWfXrD56ptTiYF9F8zZMjwaHhe8vmaCVQhrvVkvfcdTQqeTQAnhVpoVm86wCuD3vMax4Y9NuyqD9gpjkNAezQnkySmD/AzSLLKGqJeqkVIsBsXYRXJ5ZsLa8qZtDTmQFQLl3nMQMrduk6IWfxXzMoTkKLOJ8orwJZGx0tulFIZ4Xsa1JEhI8Ico225x/rgSK5jo41uvXzVDoZOn1Gz/i5V+R0DI8HFwJ6nJLn56Tqp9BpSeiWeWDul1w1Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?i16b7KIcxf2LkHl+k7jw7kUH/gRWvVuRlSdyLKYTHmwG2M5XMmILlRUe0G?=
 =?iso-8859-1?Q?02Tk33rpzA5zilOEzeZmfJ8Z8CA183wI798DcVdDNeoGp7ij6dfWYVW00V?=
 =?iso-8859-1?Q?PgoVeuga55IBfGo1JcrPPSLbiNisD1ceFPScWISIwzubb/gM+rGO7sO70g?=
 =?iso-8859-1?Q?Et/L/yepvbCyzwWo9uJkLwZJzakwIRLMEabVZbFRl5jUXto1eTTqHCcEby?=
 =?iso-8859-1?Q?3Oe60Cy3Td5nUl2Q96WOYf8Mzkao1BHRSoxg1p9+ohC8bb6gwKVCEB8x5q?=
 =?iso-8859-1?Q?hK1nfD/yqP6oTscHX6MqCCb++TL8nCin6YD59TRttdIKl05WXNnlp0hEtz?=
 =?iso-8859-1?Q?mkrH4y/3ZpmWDx/n7tVTo5WLM6VDSDsIMGoiC/FfZ0RqngbX0Xuo8Z1HN+?=
 =?iso-8859-1?Q?PGbzqIDq9DH1Y/AUUs6Py2Nwkw+OioAGx492t7hy5WP6tEkgHPagaOuHb8?=
 =?iso-8859-1?Q?ns2p/iDAFdX68bt76rJ+9KtOa5FFxk0iHiOH3qfMPI1D0aMKTunjj2e+ua?=
 =?iso-8859-1?Q?3eBDX2HYCYis+32jd4wCd+xeZ+ZG7PYhzucv2W9mRX01qtj8tRoVMg3vW5?=
 =?iso-8859-1?Q?PkXhsYqDk3ti39wUI/3f4W//UD+nBg9NNyEbAI0zV0hIi3CvdcfF31BXGB?=
 =?iso-8859-1?Q?IJH2Fq+rUJ6Y0YO7AWgcm6TakB0IZ39zdFeR8oxPLXkSBErq53/RB4pjAx?=
 =?iso-8859-1?Q?HPNurXihW8esXJWd9xs+rIJ1GgcyHCoZTCyA6nLmroyKwSg8tLEZNC6fvr?=
 =?iso-8859-1?Q?xjLVSH47QwY9qCPZPhF6cANJmZj5t1qwy9Kf/oDk54C0znnLrEXXVKFhGx?=
 =?iso-8859-1?Q?dSWrXlwclPYXnkU9DBekQzMe7hNkBi8wp8HxnQ/aeXsY2XdcjC4Jf5XMXB?=
 =?iso-8859-1?Q?YGWkDP+rqq0Y9sP0AXy8lsD64XGiC1g10oIMY2ul1zTa6fKcFgZm8TM9H7?=
 =?iso-8859-1?Q?0z1iOXDvlBnJmf/TLK5YbbqflSofaqs0k2kUEnGbPN2M2bv1O2BxftHA5O?=
 =?iso-8859-1?Q?n8YHG7S+U57h7eAVl5d3ZPcWuEk/ylkC2UjdkacxTXkjz7IlKiZErjPGHt?=
 =?iso-8859-1?Q?bw2ghx2VtXS6BK5+I4qa4vupauv2A3OfdUSu3tT5Qpr6+kaJkVJSM6N/6Q?=
 =?iso-8859-1?Q?ercVVvWRlcx8+h6+SJxEHkEY28fguYXPiDr85m0e7V1o0dpopXe+SUZ2ny?=
 =?iso-8859-1?Q?xvxCbaPH+REvwNTxXTOjmDDBu+65yD2UsHU4hMlS6GAZkhyJxrWOE+c8Fc?=
 =?iso-8859-1?Q?2zOa8iNu4xQBjIpY0+ybzph698mklzdnq3r6dAT6Mxy4Yw26lDB7YxgK89?=
 =?iso-8859-1?Q?ghruYhQQh1sNtVWFItMuDihsy3M06k1/8ZFFKFbVpd//1LJ5Ozi6TffD8a?=
 =?iso-8859-1?Q?2dk9mjVoq3gM2RasEr/KDTGxGCBCPC1QSate91qVT/c2HDjcg7pLryLYPT?=
 =?iso-8859-1?Q?2gfQAzWJPQwZ/4SbV7A88gaH6CmKkTSwF+/n3nVjCrZtb7vo8o11X9veES?=
 =?iso-8859-1?Q?KhJJKWDGOJBVJI4fVKBMO/NrbPxubq3zZUs+OL81aZY5mvPd3WrJv+23gR?=
 =?iso-8859-1?Q?q3r/lP7Er9R8JbuimH7zzzSkaIxRAZTzjRxX7t0PtEloLdSfmM9hATv4C9?=
 =?iso-8859-1?Q?kGirWUcpDb/65VGQR3WA//1EDw7MVXNEM6xK0wyG46ZC2JO6yOhj7OGfJC?=
 =?iso-8859-1?Q?MJ10vc3rKN+sJeaTktVhx1FV2iTQwpxF66y+rdf4xSBYim9T5Ppi5UdAPY?=
 =?iso-8859-1?Q?jjRaPkUQDBagHfp5UMuJ6pSqkZ079/gd/a5QjCzcvzrqUfo12wcXoXE+6i?=
 =?iso-8859-1?Q?XVQH5SRDiw=3D=3D?=
X-Exchange-RoutingPolicyChecked: a+zyf2yUIYRUjIJ2m/VVw2o0RJl46pXLOdSBcT0S2zMWJeMubKMDgMB2j/r93uYq7fGMol8UVlsF3gt6NHtedbf9RJJjRE0tyqI/Sqkj+ONxuELfIWJpE/ZwPaJniosQJGMSryoy/bQGi0Ly+L7Yu9tDCIl1UMNYwrJyjDyJ/MFmbpDAhgLkl2JCk9yeUNmzi5BIzNZ4pZkVJEL05BOm5FkSWH/3avIgs+E0rrxhJZR4RBXOQdIQNUZJBsjtPWq16OMwyK9cYxGGqkNHbef8gd/o+vp/NltAKqDPM6CZbdRXn87vxOcVkGyqeN1DR37yefppc6YGm1Or4FkVb/aG1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e41b6a-38a7-46e8-461d-08deace749eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:50:51.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1uzDEh+ym+ixIaD4K+r6a1EvXmhvHbiDDWnGdpp3Nd7I+Ggkxf3efwhBQUBXpK/US8/S28EdVlcdQH5GZFmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9769
X-OriginatorOrg: intel.com

On Thu, Apr 30, 2026 at 01:09:30PM -0700, Dave Hansen wrote:
>On 4/27/26 08:28, Chao Gao wrote:
>> Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
>> Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:
>> 
>>   SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
>>   to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
>>   SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
>>   instruction.
>> 
>> Clearing the current VMCS behind KVM's back will break KVM.
>> 
>> This erratum is not present when IA32_VMX_BASIC[60] is set. Add a CPU
>> bug bit for this erratum and refuse to expose P-SEAMLDR features (e.g.,
>> TDX module updates) on affected CPUs.
>
>This seems totally random.
>
>Shouldn't this be way back when can_expose_seamldr() got defined in the
>first place?

I split this out because the erratum needs a longer changelog and some
discussion of alternatives. I also wanted the initial can_expose_seamldr()
patch to focus on introducing the gating mechanism, without bundling in
every detailed check from the start. The update do-while loop and the uABI
stuff are the core of this series, while this erratum check is not, so I
placed this patch later.

That said, I am perfectly fine with moving this patch to immediately follow
the patch that introduces can_expose_seamldr().

>> +#define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET from P-SEAMLDR clears the current VMCS */
>
>I find myself wondering if this is worth a bug bit.

The bug bit was added in v5:

https://lore.kernel.org/all/d664ac9445b1c7cc864dead103086341c374b094.camel@intel.com/#t

Kai suggested this approach for two reasons:

1. It is consistent with how X86_BUG_TDX_PW_MCE is handled.
2. It gives userspace a clue as to why the module update feature is
   unavailable.

That reasoning made sense to me, and I do not see a strong reason not to
use the "bug bit" infrastructure. If there is no objection to it, I will
add a short explanation to the changelog.
