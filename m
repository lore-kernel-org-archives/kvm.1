Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8D638B140;
	Thu, 19 Mar 2026 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905141; cv=fail; b=dXLHGifyJKumr1NZ8OJbzPPKqTLCtGa6XOKwsYoBRz1WSOpHh2Gi5ntfpPFuxImeqcRf6bcbuD4YiZkjnBKgc6kX4aub38ogaJfwVHoeC72jPLPFdbIjGZK+kXehz2UcGBhPxg9YjyQAQFft/QFpecm2BoFlNufkV40UtW87MXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905141; c=relaxed/simple;
	bh=Zmj0CTLgdPLZ2CQhvwsYvjXupSijJ9bLnOH0lbhW9Ss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AjY5dZWzbvoCNvlt6ZDfCqUg9X8NjS5/uOtKvJXbc6kvgILhHs4S0WN/+qTto2aYK7huC+ZgqGhg1Qmea+iGMjJ/T7nsDSRXswNtGwN+WxKU6HBG0vGe9l2jfuS8MPt5gmj0dwIwBj86pRqFXHEocA0Wq56F5qD37YZcx+n+ISo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvXLTOYR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvXLTOYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773905141; x=1805441141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zmj0CTLgdPLZ2CQhvwsYvjXupSijJ9bLnOH0lbhW9Ss=;
  b=NvXLTOYRGmOTM4wRznSIOByJl+RGYmXP5KNfCeulbuxxxrppmah6jQ/6
   nUKXa/Sd3vfcGDVpsMhodYgjC7heebUE0PAQrmHMSq0IiFo1PEcoeHNkU
   kjxYaFHwp29iGvQrb9ul77Fs9O3VuULN3ETuviFaUyrY2v6trsEOOS94b
   3b64KwndrWZlrhHL7L8j0TFzq2baOqUw0XuLGITy+utbt4tKVb6180W+N
   OCKO1oDIGH+dRl/+NVywoNaHJkIz29w8ZxrtliOvBeEYz13knmlY6/YeN
   pUOh8nX9PjA+FXRHYWx2+lNNLw7UzHaPVItaVlYp5vQ66kU2UFT4xsJJX
   w==;
X-CSE-ConnectionGUID: DHl1dXSuRSCSr3mFyXRopQ==
X-CSE-MsgGUID: Gd4VfA2ySquunk9xl99pIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85288488"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="85288488"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:25:40 -0700
X-CSE-ConnectionGUID: ZqsA73qtQ6mCBy8KZMhj6w==
X-CSE-MsgGUID: A1N0VLRIT9OqOHCGpO1Fig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260777450"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 00:25:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:25:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 00:25:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 00:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lknAwE4J6mtSVRjy1jOYY77s61i56ejjIOc3KNQB3xB6seeSognsi0FTA9mbf1MlupGI7+ijvy94lYDVNhoS4EhBcIaGCGYvYThZi1GGjNmuNHxNvXQr4YjLg2qC0HO0wSllXyGZtI4gnc73so5Jn40pFn+32V46uPGliG14llspzSKE+L9aAuxiBXRSRD93CCVTlcF10iHdw9Ip1Z/PaGv8Ps/8IAe+0UItTQu56Ois2mLAiX+0KRXYSF4Qor1icXuKFSCqv01ERNFAgndU24KVyQqpNeHQLPBJYIho3uxrhn9chg0X38gSClyrUTppc7GOsGXaZlZf+Zb4inaUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni/z0ZeIMiwDDElUmgV9JNGGxDT1Tb8jHDOJ/wb9q5M=;
 b=l11O1WIisRbpssmsI7mwSyqkeHm/Djl7NWhMFIUOkOjDohEp0xKaa4MvQfzJTK8WVlrfMq07GxLKrC2SsRpB6GdJxkru61wStXVUvoRtiPphX+kN98XMutFZA3sm9ZmXOpK2H0nptmgsbdB0KTDah5ih+q3IUnc0IFBrsylqJEXFNxNSghq3ZfBzzLqaIXh1BvI+B9Gt14uOEZkPZtlwvnFQKD6NcDg+O68afUZJAlnzX/FERkYwYavb5PJzSTJVh3vt0BtaPJh3hsZiMkxeGCysllBop49Zuy/feWLZUi8t47i9YcDhn3HkOzv4Uc6ApDp5ztiMgjgnUV80cQut3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by DS0PR11MB7358.namprd11.prod.outlook.com (2603:10b6:8:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:25:34 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:25:28 +0000
Date: Thu, 19 Mar 2026 15:24:52 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abukxFDD3g0sKYXP@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-9-chao.gao@intel.com>
 <abkvOYQIi2RvEYh8@thinkstation>
 <abpnWkENgaWoofZV@intel.com>
 <abqFJZo632DAFsl_@thinkstation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abqFJZo632DAFsl_@thinkstation>
X-ClientProxiedBy: TP0P295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::12) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|DS0PR11MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af2a4fe-70ab-45a5-4dff-08de8588b1c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: p2ZddOuHztQUb7KoUFvhIpzDy0U83d6f3JGzNlFpI18nNDdt2H4yxIyByU+Db0h0NczvbbQrE/zqRD6ZBlTKdCDZnvyiaSTa+856SL5ecfq/wwO352m91IRuWqXXusLbijsWKzNiqj8lKMmaCvTZfuGy0RGsHCaaIR/xKvg9hiGTEbtVEz60gfbfNXjPE++zOA85WUg7o1UDsYCBlK9ZoFt4kcx9e2lVMfa6pHuoZpBeQm+jFRhXWcBEH6m2DLul/ZdC33JbwYNWsoghsyLqsHkekjPzd0uQsmIuDetgbNjeEnvTmgZnJcOAEX5KMq/1UwNXqvv20IatNZVHzFOGhAdqTluXD+omgJQPkOTSAjHXg8aLS7tpfWUTUdX254+aBfJ+j+ymtz8MjedvrxfE6aY3SNREFSzleg37m5usHBilpSthc5TTIwqAGCEjzGH7Aji6lAXW1w58ZNAUY4nLcarq+NiGf1XieOmG65uCXl4GObyzhBFM7qz5VaNraQHzvTmt0ayvO36muFaXq1EdWVcWWQaIGQh54XXv4vb1z5/wteS9Ccc2en0XCplnYSdOfrYguUTcXhA6fMGReXGYvfbrALqGR3GXqYVOvfRVEdB7CbOijVoIsqKlZ+gSEXLYw/AqJk8+msbBuGptrmvVkuK6dgmgfX8JaYTewKMaQUKuAwTTdKlpgFJSg/20fWoMg0Gq3sIBzK5AtkEZkha40Hezl3SLJV2A8VaQc4+kuvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZKA7kPFT+g4/kjLZ79eAcws33lQtHDcJ+Qh3sPRNbEhlj1vnQFJwv0vciIZ?=
 =?us-ascii?Q?w/YTZDm7mZRieatgjHLPvVEJPjsHwnzpGFZRLKaA2x9IHCd/RmdUPjeUvX9d?=
 =?us-ascii?Q?8cSYBrwrwQ7Y2uJjSDhtAOl5LMMjnR3dQq98R2w3NxBZL1+8yw7supxb42Jq?=
 =?us-ascii?Q?z4JiVRNC8ncFqvUKp3cY3qcAqiu1uUHAs6vVcu4TTHSau4Se1yQ5aYbSscBZ?=
 =?us-ascii?Q?ipuxXwcWwYciVqBaN2ehc5XNNKwu+BhNdFWWKyq5zoDvrkER1JxXZV5k8tt5?=
 =?us-ascii?Q?LRCztJhPE0Jqy6V8UwUpZYSKxfYnpdyG++7zbx+vs78zwG2WupFPyem5x5lR?=
 =?us-ascii?Q?5hPuzYE7ofG7IZx/BPVZIRFEWqt/ubE1zIpg+DCZhEHq2nE80Czgv3OCYpDs?=
 =?us-ascii?Q?hR+NafA7Q9PSzMy2cjZha6mHQnn8wShFPe9ajDn7CiJtmDzOKFZojbK0yq21?=
 =?us-ascii?Q?ND8COfRHh8CCPBRV/dVuwNnhV1+yqsqaXnADZ63RZjkD8v4XqbOoAWO2CSah?=
 =?us-ascii?Q?+FJuyRObE+oEy5kt9agAP/m7iAAd8jeOm+Rv6APLNo8BSnYMvJ6ITEm9Qqbb?=
 =?us-ascii?Q?AcO0RJHWNRvez3XJ/Kbv2XqSnYHj2Ck6PKyNtteEnzhbvSlO85vqoxGxtE6z?=
 =?us-ascii?Q?XyEUGlW2gvPaQpJesM1QddKaCuwWaNVHUvv/+EZnOoYDz1Sgs+djADcDWDiS?=
 =?us-ascii?Q?lmONecUQoy5AvMZe1Jnl7gvb53/ZYoStYfFQVfvqsd/iiX82u+2Uz7SbrSWG?=
 =?us-ascii?Q?69RaP1pcd2gyj7J4//gQS3UJeA8rwXIAwiFsQHltujSlGBLEkIZoF8pNYKSk?=
 =?us-ascii?Q?EZ6HW7ygxMIUwFy2/WfbF8H04kAuz+q737ulcebc/x+aw29PptRxaD5l7y64?=
 =?us-ascii?Q?3IaQOeyVrPEmhpykc/ucymMJT2XyKfh2+ZMpyWA6+I3bE5grZs96rSgH4bf8?=
 =?us-ascii?Q?moaaOt+JCafSMbnmqyLbCVaIT5WT1iU7XqKx3by8cum90sj5jtlhOvruwHLU?=
 =?us-ascii?Q?caWiUggsSam72+V8BkSXnXo96eGlRLI2Y4BA88ndBDMBDe9utmLriiuXClyq?=
 =?us-ascii?Q?Jk5nEOvMHtU5yRasrR+l95fRnGSWjSFgrYHJuBwZCMwiF2umcm4uUGby3tJj?=
 =?us-ascii?Q?lo+qaRbJTO9g30NLZwOSDeXplSvPskIiOFUAGPxCPyMLtqeo/bI1c+9Mle6w?=
 =?us-ascii?Q?5Pau+BLH4hx3OyHkd4kvdIJDncRQsd5Z+pA/efsZHzVzT5jIq5gX44Y6UxlY?=
 =?us-ascii?Q?QlHCCCg5Bj4cv7E3IoOVR6s2coACRtBjQ4eLoeL9gbEoQWbZW+ZYo4qQogpR?=
 =?us-ascii?Q?NwFPAvBn9I8Yk30MmG08wtWUbXkTptiRv22fZPqPKkbQthQ3HQ64sYU5u37M?=
 =?us-ascii?Q?S6t+5ZlNvpQcJLREjyDdGj1wnZs6qCI0kL1v20ZyWVoeoXy8c2IiYJ55g9eO?=
 =?us-ascii?Q?q0+bfaRhBLxX5rmwIG4uZ+fNYAicyTPB6tWwph7CJwVIvUNZ6E7zQTTgnGi6?=
 =?us-ascii?Q?Nnc22pCJLtTllZaY86tI1xjgRMnb+qJe/ckbd3muIsQSMY7Vxnevb6/BXQnd?=
 =?us-ascii?Q?HQ9Om0/OwIfVRU1ltvQLb4DFuWUmRURnZcgD/KciTAsA7TvgMP5dqLpzlO91?=
 =?us-ascii?Q?G3sbA89/0LkmgvHUKzbQYpo4PYNFbhzXi+NATSaG856TZwdrhDmaW7BO+b9Z?=
 =?us-ascii?Q?ZK5CxK5yepkgmcGEwq1DuNaWeXNcHjOzLG7Q+q/+HIBHVKXr56Mjl1mX9Ffa?=
 =?us-ascii?Q?Xq/lChM36Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: aZGbOB2qO0B9I8endadx8K7zovhBfBVXHzzCQFZsC23eucWUYvQ1c/AVZ/CNeBDRP3ML1yq/JcrYh5HmZ8wBw+m/93WmKoanw94WnQORZwMdlyC+gBZROs2ex/Iq72j1Q+YuTNlheS03iZ61Pce/JZvqHip9+iyGBFZ23Voxz1+jzZ0vsQTi5xhB2bdpxoqeBs+avdIPn9ytmTcV/UGwsXY4pZwwq44WYwsLvKDbHcjwFzJDXOmGcSkVesXs5LTFIK6YA8/q0nImqbXO1wI0sL87DW6UXEuOFtvPv3NEIC2Nv0MyvjONewZilfGDl3gHAtfTotyLTILMe6BaK4Llqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af2a4fe-70ab-45a5-4dff-08de8588b1c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:25:28.0981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPD85RrygKc6LK6ggb1fnWGXss38n+QhCBSkK6WnDnnpbRFLeuNM2N61sfJS9w75d+5HKxYyy1SFgy2TNe1ljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7358
X-OriginatorOrg: intel.com

On Wed, Mar 18, 2026 at 10:58:44AM +0000, Kiryl Shutsemau wrote:
>On Wed, Mar 18, 2026 at 04:50:34PM +0800, Chao Gao wrote:
>> >> +	ptr = sig;
>> >> +	for (i = 0; i < sig_size / SZ_4K; i++) {
>> >> +		/*
>> >> +		 * Don't assume @sig is page-aligned although it is 4KB-aligned.
>> >> +		 * Always add the in-page offset to get the physical address.
>> >> +		 */
>> >
>> >I don't follow this. If @sig is 4k aligned in VA, it is page aligned.
>> 
>> Dan's concern was that PAGE_SIZE is not guaranteed to be 4096.
>> 
>> I agree that PAGE_SIZE is 4K on x86 today. But to address that concern, I saw
>> two options:
>> 
>>   1. Add WARN_ON_ONCE(PAGE_SIZE != SZ_4K), or
>>   2. Handle it as in the code above.
>> 
>> I didn't find existing code using option 1 in x86, so I chose option 2.
>
>Please, make it clear in the comment that you are talking about PAGE_SIZE != SZ_4K.

Sure. How about:

		/*
		 * @sig is 4KB-aligned, but that does not imply PAGE_SIZE
		 * alignment when PAGE_SIZE != SZ_4K. Always include the
		 * in-page offset.
		 */

