Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A984718CF;
	Thu, 10 Sep 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789076352; cv=fail; b=PK9AGF4NAzlIz12bAcF2ofatNJ45+FMEQ6Ufb9faju1N6jBEkRu/b3LQL9vdXDtLaD6mDYguGuvTmNBFg77/WUjrSvckXsC40n6XBlI/1xkk+//OjFfvtyatB1f+Hidm+k1jyTVeLlkX/eVj3fufXV4bYr/MMtJUXSViwaMv784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789076352; c=relaxed/simple;
	bh=BexQMN86a4ugCwSYE9E0BM8EEMsb+k/cwratRzZiIFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XSaimnID7ph5sPYIt3wwPeKh3TTLRCT+g0+sKgR5Fw79r/vjoygQ3t3FcWW7YmKQIYQOR5IbOKD6cy7fQxLi5YnZv2SJljosNgr7Zg6aywO68CmYrwj7wAKdj8eGUO9TMeBFFi7ZZ6xSjjidawFF5jjuoK7g0kdV8se3DWkfbCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAsFldFK; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAsFldFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789076350; x=1820612350;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BexQMN86a4ugCwSYE9E0BM8EEMsb+k/cwratRzZiIFY=;
  b=dAsFldFKNIs0Sh1iawBW6+M486W0xg9UdmBB+4oqLREFQb3KlHNT2EVM
   0JvUmWeJXASACUuwBe/UEx//R29dj7rbjMg0ayLNKK+W2YwUYrTN/OJgQ
   04nPvrhCpLy1R/0KuX66ey/ntqa3McNd6q6dhUle2FG8TpXKs+YuKalOv
   PqlLa5kSjUlpNvlx941tCUwaKs7OuB5+dqnS9mMQB4VN3/t3OF+Ch1bEu
   BzJ1cpp2PJQTaHdLg8fQBbKZGgPo0BU6yNHRSnfgPNYp0GzRvUw//nHDN
   mp+3PGIXLNgjeIKxC1wXOaK0v33GaIQtJbkNJlYbCS7tXTjY/dXYfUx8v
   Q==;
X-CSE-ConnectionGUID: RcuQQlwoST61nfcYWYs3Zg==
X-CSE-MsgGUID: jUIL62EdRsSUARPaL6DclA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100701079"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="100701079"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:39:10 -0700
X-CSE-ConnectionGUID: 4/nPhbg0TmS3eLyvpTFLhw==
X-CSE-MsgGUID: M4GPfQccT7idhGAnMJagHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="269154436"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 14:39:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:39:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 14:39:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 14:39:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGSYleVsr4VCzRtZtdsKTkhA24RkcSk5473p0mZgi12eG7VhX3pBp2ZGODtLQ0UBZNF1BxFv63Sq6epRSmNd/ikP0OO82G0kE4oHK4EtT8p8r6/p/N/7W0x3dYfgbZjduGaAHzbiNd2eAnB6Bjx5z+d+8HMj5wh0dfMAan+HyXkyNSghGTvkc87om3upq88FKPyj8rlBSBo0FjPmOVps1BviPOf1C3HFAqxBfQNHI0NsP0pjbZGEY7ogZrq/gQSF/D5eKXbbT0KFJZ+/TQFn0GvgilTRZiCrG2iVJuMJtN3XKgJ+VM0LIVBrwAMwz8y+ikYzpvAyzBLZHicQOnMkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgBQFp7L82bOz7EiK2ibWPfLDLNDv4XZtqAeXgl6I9o=;
 b=rmjuFQP1NH2e75h5VyCFABG3tluyVJlvUYv/FpndmTbUjiJFL2OFSKOG6oRGZi+HOmkT7ZWZv6lRi/o8NfnpvyIpsq/rha471sgmEjPIgLfN+8SPTCyD2mfRIzuqdTW4dlb+bnEBMYSoTabZ3e6BSiIpyZffJVGp1vjRuRur2pedxawiv2VVuc994RFRoEl9n1ghlanp1P0jVYdjx4o8JDPpyAAN6j77KP6nROTj0cPPY1i6NnpDyjAxlxgVxU2+Uz+PQivml7ym+xPqf9AeVcAZ5uWEPFCxpMCAS6cg7z8oJjobmx3LlDFuGPz/Ms4CU/xdW5xMT6jbub3632b4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by BL4PR11MB8800.namprd11.prod.outlook.com
 (2603:10b6:208:5a7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:39:06 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:39:05 +0000
Date: Thu, 10 Sep 2026 14:39:02 -0700
From: Peter Fang <peter.fang@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Kiryl Shutsemau
	<kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 3/4] virt: tdx-guest: Use a variable to store the
 Quote buffer size
Message-ID: <aqMjdhBtg0FntHjQ@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-4-peter.fang@intel.com>
 <75441677-635e-4a2b-8e11-f5e70a1433a5@linux.intel.com>
 <appp3yiDbYsekIzP@intel.com>
 <8d20d04a-3503-42d5-8aa0-90b96aca2fe4@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d20d04a-3503-42d5-8aa0-90b96aca2fe4@linux.intel.com>
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|BL4PR11MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0c2b6d-5894-4dae-547b-08df0f83efe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ckS4HERArgc9HbL2frsEq1GJcoE6i4BHil++sgcK8GgQ4cqA3i6HR7O1FOBP3ZU2wueVLuDvuf8lHqD5emqtMnRDBubi8JfcuvT0Dpi6xFOhan71IB+XEGLxnT6icyV/CdZIb3C9aKrCpzF+GKSmg+p8RM0j9MNzl3WaFcj7KG9dLnBJiwgsafuW74KN02etZzLe4fcsTkORfwM9JBUp+Jv5gshs5pyP0Km5cC3Pq1pNoTf1UekKLkgJMTc4TBi03hs0ImLQ7MvWX7evCPZ4MUPjS1KVmzmgyyq9IqvSQZtnFl5qjbzddFGRRjEbBN4yeDAzrwrfwA2byW+Mm9jZa55OXt5ucdESAuWWCfMpIbVQFjuywpKA1ODdN0MMfTUsJQf7cU2DVlC5hH3dhEJSkqDqbt1B0xs0o6mgzdC9VgqSX53+HFSFJVVC9NX6/kG0cD5Bi5KFbXI5+Ql7v9NgZkqYFe+tx3AhvMPJTZKWZ/bQdVLyfVknwGyU2J4jsFV/EB84DnKWAd2dgoYmJgJoP1KStSvHSXmjSxQ3Qsc2eEAinhT+O7qODLGN+gB4wa6LldF/GSQio+RR9yhL19rsGfCD5gdPHx2Mrf5oH2dEZ2y+63nMcP5IRKtD1uzabDyKtubXcWtg63GYKFszzm4HT/p7hpBmxOgtOov0WWBMREM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZfjOTd8e1RLYAiLKMaWae9r2NFoz0VuFhQfEzJb/WyLhWrntCI8n/Nz9wF+5?=
 =?us-ascii?Q?tBoG98emaJBpyS47fKRnqKxWANVecCjLd1nck8Z9109hVvklQcl37SNxmoH0?=
 =?us-ascii?Q?qGQlL+4/UqiuvElYX0oz5X/NmopB3IZ/3mzdSmK2Tqn4EvH1/PCWY0XI1rJW?=
 =?us-ascii?Q?DRg8a0ZPMDwrLijA491+O8cikxbSmlK4+EJMi8JiCXbAys69InoVuG7zQEdq?=
 =?us-ascii?Q?ItQqBxAvJ/dh3kBNiv1G4rZmAkmoQtsRPxw07emf99QdYkNvWXS5GLpwk4ot?=
 =?us-ascii?Q?1L34MGPhK1ssMCOxWfr/LrPIHTRD71GWAHHr3ZAvkySWYWRcD19E37NHOqUk?=
 =?us-ascii?Q?iAInOuIAt5pjHzJQ87ycubDPkfSO/69renjDXAv72esb5QkhCFbA40jJtTvb?=
 =?us-ascii?Q?SARzfvT/5k2PgpA0+WfJf7plW+oz7NVq3AE7sdGKZl70Kqtfg8axYHlcLi0e?=
 =?us-ascii?Q?MKZT+qtrTXr9ayZ8IkiBIUhZb0OryQu+GHmb0LJDIcsEgrVT+VpFOLw52MBQ?=
 =?us-ascii?Q?syLHwKZ361WB8mJ5IX3TtKsR5aFErUmu6EPy2vBBvuEkIp2yEYyV4M9R6bnp?=
 =?us-ascii?Q?DZlS8jq1rywwgRHkMh7k/YYwTsrr5e1qNA7mng7UH74NGF/s7ltPK2PA4uTt?=
 =?us-ascii?Q?4BGwFhsH4uWrJ3sq8kKCPdSAYt/gOI2SXn8LkWCHB5gazDos2sd6JDEUUSm8?=
 =?us-ascii?Q?Ulg1SHlwSspB/r6YYMDcftmki4zRdQWOP72QHQC+89prwCp00IGMhob8uSrh?=
 =?us-ascii?Q?Uc5/RLBeHgarde8IRN0+3NN4b8d5C5j02ZsOInbPQwuzogHxeyBeP7k2V11Y?=
 =?us-ascii?Q?i5wWegwElTl0tMnQ6tIZ8+/btnkWr/KJ/SW5LuYtujhqC8ukiEzPH6uaiyok?=
 =?us-ascii?Q?0u0mzVgTAAfe7eSD9AgQzQFV1FEjiWJJRyBy9G1KqLcXt90Goixj0I5i1xE4?=
 =?us-ascii?Q?1XfecpfywoNYea4DYJF/ds+0lKQcJEWwsSVDKdxLMYmk/A05qYJQA766EmXE?=
 =?us-ascii?Q?EscPZXaSW6HKP8mWaGAO3Q+/zIlX3Wq/xfoRXEWvTMtzhbxblc8SPpIEP3VV?=
 =?us-ascii?Q?hF6Ap8XPW1qYmHXwoDZfRiQnG5FrGqP750xfRKPxzXE2fY70S4Xmhhvsqkjd?=
 =?us-ascii?Q?R21IbivYYEcHIH/Cjdz2rcQy6zRhK5vW+oNi+QKQ9OxXlDxL7cQLo8fNsb7z?=
 =?us-ascii?Q?XPMKFR4Wt6q6qAsqAtVPUVppzj+SwWi9yAH/mqdQOfk7H2e2TNbmPYrQWcmY?=
 =?us-ascii?Q?WC52AKTEW5JGtgwcu40uxr0g+KG9A+ByVqfsrU5uPdnIqS2RxC4o7GkiPigQ?=
 =?us-ascii?Q?5qeT34BA0qVL9KkXSs1igu0LX5SYoj2618Fxyyk+j5AWcseNrZ2wDbNB8+eq?=
 =?us-ascii?Q?5ce6hE6ZlNuu0KngM/wkSD3RdUIVS91Byg21/zB07GQ0MxsAHsrZqhHIFV3o?=
 =?us-ascii?Q?NCjQ/joSvJbvho/4c9RTx1lhwY02572LL8GGFyvK+grEgPv0MV1W1+h6mIz/?=
 =?us-ascii?Q?Kx33CHsS/wRSW0WaG5rW01AE2c/PNlu08tFFEFUllQ/YhhHgDFzstl83cmbt?=
 =?us-ascii?Q?R9VsG8IPkbiFFA+FGu5W5Ns0wYRW9INK9bwRMydGzGfqMHxMwBHyhDGUFgsT?=
 =?us-ascii?Q?BBa1pXDheDBTKWgrtQ0HYTfwzZHyNqGTxg7iYffLE9L7be3DeEem+sKxkM/h?=
 =?us-ascii?Q?ccUttZNsztG3lf4TiwGtXxWLhiw/FH6uMIR5eQTiJfKmXIbUNZtckZEchRx0?=
 =?us-ascii?Q?fGMuhAh8sg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 2PSpXQhBrjC32wh9QL5sBJPpYs1EK5tAafpz5mzcou4m0XpXFWLt6Cwg+XDWy6wGZFqRZ+ZtEmEJR8aYbcMk040B64kmoAK6qk28G347Q5RymGVUZFYbk9HH+UVDvylxvhRPW5/Grwtc3xCrV7Xre+iwx/aQbFtOZ0n4Lhf0by5IzMEDOalEFlKwfPCNdMlhzLHcFuj3oai+kz3w1+0WI1wAtxRZQiMqvRHXLf7oD4P16SWI3BK4annH0cfU13yu8YTg2OK8KG7p7rMfuCl92Apl3IBClV5FBYp7qmi+A4T+EcXDDgTsR3yd8Zqtj4fFF9Dxhl0seP3/TSv40kAvbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0c2b6d-5894-4dae-547b-08df0f83efe8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:39:05.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRHD2sBvIZudonnyJRb6/9QOoYaErgFLkViWQVHQtkv1GbJJkPyWYBbls3RbQefTvCVwF1lYAF+QcMHZYJ0XrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8800
X-OriginatorOrg: intel.com

On Mon, Sep 07, 2026 at 03:55:22PM +0800, Binbin Wu wrote:
> >>
> >>> @@ -191,8 +191,9 @@ struct tdx_quote_buf {
> >>>  	u8 data[];
> >>>  };
> >>>  
> >>> -/* Quote data buffer */
> >>> +/* Quote data buffer and length */
> >>>  static void *quote_data;
> >>> +static size_t quote_data_len;
> >>
> >> Nit:
> >> The existing code is using "quote_data", it's natural to follow the style.
> >> I personally feel the var names are a bit ambiguous on whether it's the full
> >> quote buffer or just the data part.
> > 
> > Yeah I agree... How about I change it to:
> > 
> >   static struct tdx_quote_buf *quote_buf;
> > 
> > This way it's explicitly typed, and should work better with functions
> > like alloc_quote_buf() and free_quote_buf()?
> 
> tdx_report_new_locked() already uses the name 'quote_buf' as a local var. :(
> Maybe the local var can be dropped, but tdx_hcall_get_quote() takes a "u8 *"
> pointer, which will require a type cast.

Yes, the local variable can be dropped and it can just use the global
quote_buf as is.

But yeah some tweaking is required to make tdx_hcall_get_quote() play
nice...

> 
> Anyway, this is a nit and it could be addressed in a separately if needed.

OK, I can add it to the cleanup list. Looks like this is more work than
I initially thought. Thanks for the review!

> 
