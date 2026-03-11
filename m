Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8423E334;
	Wed, 11 Mar 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233444; cv=fail; b=aTwhqEBX102m9rgg4mQtunz7WeRLjbFxu2A7KjsmJBb+vzQtf2cGrZuaKKui0E0sFsSRb+dVvmEvr/ORyCScRMJcaFEKU0uXJfw3i1MswDGF24Y+yBkeT7D11GEkyJ4sUSIYj6TkR8gAIFZTyUrdrEWeyVEJB2Z6RxPy52Sa+bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233444; c=relaxed/simple;
	bh=6FXCwEl9oQCwrc+bKvYcR5a49jsgOtrOnlMBdsMo0jY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PltEUMFwlpxJ2ve8wdqSGJ1+RzZcGlfZsfPydb7pj2SLnVSTSxpE36OD8uwQYuzLB28LECNGAi0ZBjD8ftyW+jYauPDPu2pmMhWFQIcDq8JaJk2y93s1uJm9gjJSs9Uq/u4r7zk7TOOad4JGlAGDveiEaompdgJSlBNW5mOWHn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SV2ymDsJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SV2ymDsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773233441; x=1804769441;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=6FXCwEl9oQCwrc+bKvYcR5a49jsgOtrOnlMBdsMo0jY=;
  b=SV2ymDsJIOqhIlSASU2j3nl8kwWrqrxlYbCoaCjDRm2w7QPNi2TKZif5
   NG1WA0LFaV1vremeGpnr+9olR9NFeN9fBoDbzLoxsXPZ4NtUKrYEGj/nZ
   wo5mRN/3LMsfV5ErwTB+RVacUnWbPaKOL4DO+xBw0V/IVT1H4jC8eee+R
   YalQu5keRc9j2997fdbFRLNzYYjDG4Z3GFWEjtPt1Xybqh3BUhhdEI16b
   ROVH6ghoaBCGiJTXsryXrCFBSKnIfwvoDm8b4pa19Ls8xMnuecy0SfPIS
   SJ1ndPvuc/1gzflz8B1TUl0Vpcoi9Qy40/JGF9+AoRTm/WwqEGrew2KaP
   A==;
X-CSE-ConnectionGUID: sX7dYrz9QK+WejFeXA56Kw==
X-CSE-MsgGUID: OC1vbBQfSMGyG5c0qTaIkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="91679545"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91679545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:50:40 -0700
X-CSE-ConnectionGUID: zKKQSLPTSa+/9KLUJuc7Bg==
X-CSE-MsgGUID: 3GGwT0EqSJqOsMDOatwL3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217925442"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:50:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:50:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 05:50:39 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 05:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxiO6XEeZsDq2y3ucp1KVrT1GBe6uNYcA2mYXFT4593VICMilz3YS4zwOT+hfVcgKwIw8AegagWokoviV251dW6Y2SmqY8TicljUrmxDPoaWauP9FbHTDP7zx5dYRITqOkNg8SvzmKPzEwmZN6h/vnrgxfishyYEB0TO+/QIkk5HYh3dAgkhRUwBbLFKuSrsk46qr9xk5QI5tVhj34uLYl8lHg1XxVJmy2sGVlcfc7fl4RKUmwpr+L3nHGtms7jUrdVat5xtrS36UKHIrIHXG7y3D5/G7xGJCndM52eihNIhKHrJe6RDdlWLWPl7Hou5UxwEieZzh3sA/OENuKt2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K97boxsHayZNO9k5q/bIyW+sNCIRclFMfml95a3XNc=;
 b=ic1T1HqUNW280S+GyF1LXTVZnIl7neK2ssxbyOI9xGkwOFN44df33rQ/YxAFa/mxK5YjKAvib1Hb4kmmelkTBl3Xa8MWnF/pr9xtooONJ6zuPa5IpbB8vXAnO6o+/5CEYjn6i54qbEa5HqR8poo2O+ivJkU4u0cVv9cchTIIEBWszYupoF13O3LINnkC+JSUXhS5lliRE+nzF6L41pBiLbcglE8WTIUoKQQdZAO2K/tcvsk3g1dgl7MlNn+aKWJugMt8WUZMe2JtPGTnC6+jtinbVpizKJpHxUCOwuN4IZF+MSWJfK1hXZkwqHX/gWKqUIT1O9GppxZORZCzSAobOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH8PR11MB7119.namprd11.prod.outlook.com (2603:10b6:510:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 12:50:34 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 12:50:33 +0000
Date: Wed, 11 Mar 2026 20:50:18 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>
CC: <reinette.chatre@intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<dan.j.williams@intel.com>, <yilun.xu@linux.intel.com>, <sagis@google.com>,
	<vannapurve@google.com>, <paulmck@kernel.org>, <nik.borisov@suse.com>,
	<zhenzhong.duan@intel.com>, <seanjc@google.com>,
	<rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 24/24] [NOT-FOR-REVIEW] x86/virt/seamldr: Save and
 restore current VMCS
Message-ID: <abFlCkNd7tqaUyAP@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-25-chao.gao@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260212143606.534586-25-chao.gao@intel.com>
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH8PR11MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5911344b-ac7f-49ee-1243-08de7f6cc8c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EOHUuQXkp0CUP3IlRQUVvVV6qaAif2c3hBqHvzkwgf5+9TkewjqK/UXoIuy2G08+no+wkxqXachiYe8g9VqfkfCCy+DqNYhmFJTWKV7XDJIBAU8aND+cWHOUYE3q42lhXgLUJnSiijh/6lbNyP73EzfqbGEpq8sdRVSg85/N4wv0SPGkQsbIWbA/3raMbck22TzVEeBzCJ+KRZxGTAn3mL1CbwAd5aR/dHxX2yCZr7xZKHARm0uOwcD5BxlRsHFYpe8pKAIXfNeIBc4kgAH8va7LjktXNLnLGBmNrC9rp3Z34tQi54SSyqHCAPCcStaacZ1+b/oMmP3mD0xRpIc3iK/AF/qc9D4WMUO1GmbxOhTxbPNyGNBta4xNn/nq8C1TRYMKf+EjIEG+zX4Q2s569Nr3E50SenStPkJDMgozr0BEFynnZdJ1xxer+2I2oZARKgsi9NsmYqExPyYUgnFDkqbhuT4+6XFvZiJxnWcawXB4+nSQYfn1OXH6m4WFw4FolKd7MhD4ZP+hoRzWrWb13NbI5z2JFBmbpzm4jHdWobRcwVsdVjjV53vzEIWCngcfxqmPvb8ZiRMppAgZ7H5cN++l8SsFy73y873pTFeZAPUKkXW3KlqEkQSsWi0ylEHRxLER/Ul+0OaYHBPKqmN6s0iQM9LMm1VkSHKFHpjuP5ymRfRMTqefJVuW0MTKm0z45grBKPV/9QPFTGWX+8hSC3YwZ2+R6F63r/HnzCPcUByY/aiGLY0G1PVvGPMQVtxy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XqDYDxPg6jXB9uCzf7XFgulDScnSEeOPNTRKFGO/VBMGjW3x7gJHO3Nx/3?=
 =?iso-8859-1?Q?AXBXmxwd34Huu19MqBgEjvHK/qJBMb01oFceqQvTIrFmAY+YfzS6JKXMjd?=
 =?iso-8859-1?Q?Wt2PVmM68f+QVgaIq/XJBdtlchJxMzIAP2kOqieTHhvfueQJGaqDeSqMW0?=
 =?iso-8859-1?Q?mB3IVqWoxNsIGlK45YsQPhljPnrazmmh5bJ24+QpDn7uXSipscu0SA2tMJ?=
 =?iso-8859-1?Q?6D1EWfnCVRnmYDp1+Apyih9fTAoufk94vGl2mqQloBZLCQJffcytahXjVs?=
 =?iso-8859-1?Q?0FBquMhUmJACs9gEOd6SYUga4AePq9zJkCqTr/tOnNxqyUCbEW8YN/4tuH?=
 =?iso-8859-1?Q?aAC/oggG4EVesbtACyrBuyF2/McPD6Xd4aEq9VyzDXFV2pn0u2AuOSoxjC?=
 =?iso-8859-1?Q?8LvnQdlQvbnxmnB7QwZYFynxLEdrlrJ7yCSl9wiLMAxNn3/WO7ADOYgbgn?=
 =?iso-8859-1?Q?3DGEUPNud7YRfEvtgtf8Ghph01lHfN4VF7MQnVe/I4a9pWUr8DzSrEW9lz?=
 =?iso-8859-1?Q?26kwnT6ewnl4nSTqcvjYD5SpDtBr9Z0avzRJCGeYOupz3fpegdGIjkesH8?=
 =?iso-8859-1?Q?1TXPCH9u+XUG0C0iYde56H9ON/0FghYUfv30v6TLr/eaJBEwUoRkehrd9/?=
 =?iso-8859-1?Q?GZf4N4mVeq06OQG2GXbIzqXoBaxI8IYto4KKLRX5ZP9hGmKUpfhWELbej2?=
 =?iso-8859-1?Q?7ZdZQ4GdRE0XWEUtriGwRYBg8TJVXdiJJoTqrDkd/wkG1W0aXhfY1866l8?=
 =?iso-8859-1?Q?/VQQaZ5aSZsVDkcW/U71W92GZ72RysYloQo/lD4pMBh8Ryk4ucx6VAcp1g?=
 =?iso-8859-1?Q?pyH/hCtvtBk3IlfaGNTSWQsXlwjbM139YjrfiVuprJJmpJs39a/+ru3ui3?=
 =?iso-8859-1?Q?yI4UqGZkFORsP/GQufoAYLkrAl7I5xv5Ud36cFoQfl/lkhrEMX0rJikit9?=
 =?iso-8859-1?Q?oDv0i1xAx43VpCf1QY+rWEfRYIbLXciLY88ZyqbBuAbIPVxgYhPZ35MCM6?=
 =?iso-8859-1?Q?xYhX1wMf/inIL35MCdyGq8uEyn1yfZXwtUr93X4+f/PeCvXw2gSZ/VFoNE?=
 =?iso-8859-1?Q?7SUAuQSCuhN2YULYqg5tzo8UDeTa1DAKMGsV3F6K7ZOOVngE3dMw1ngToD?=
 =?iso-8859-1?Q?8gvbjaM0tAnUhJ9yv0lwhxqW7upxmHBKrlpAioHNTzd6v6HB+gEgDAx3wT?=
 =?iso-8859-1?Q?1wCyV2aCWelJ47NtyfHholQzngAri+TlmDXo6Tl8u27hEu59srtujTBNmC?=
 =?iso-8859-1?Q?iOse0Kv4guOhjLQf2b3tqZjZgrAOc5laFXbESQnaCgY1WIteYOEPnlhPto?=
 =?iso-8859-1?Q?ZBBv5qd/VUchvIswbCM571ghhLImn19Ofi5mUkLOgknNVH1OVpC238SwI6?=
 =?iso-8859-1?Q?HZlD6QPl9nIKqljWSneznsp4OnolBwUm3Z9C94lsuNivKGN/NOgsBW5QTY?=
 =?iso-8859-1?Q?sBT4fQ2InTS7RVlMhVe61W3SJVT3Zv6gpegb+ynI+B0y06E9UDiF8WHGjx?=
 =?iso-8859-1?Q?+z0YnCWJhKbZlLVG1NX1N143naZKpNHA6pdaCPz58APR83mHe3932Yf9WV?=
 =?iso-8859-1?Q?4NSfILX/Dtpdc1F+i+fzqDj/0aFJPdffqwdYUq/LrHTbEycFID76nGEyc/?=
 =?iso-8859-1?Q?uPIp1HFMakD06p4nMKqaOxAFdAaY2CodWVt/45OrgKl+EoMbltAE6Gc/iA?=
 =?iso-8859-1?Q?pXVNrw7RTBVP/8+RRdkwQlA0kd6zjfUdfn0zJvv3yODxGmWWysHfVob+JB?=
 =?iso-8859-1?Q?THtsq3EPoojGtrHL2UXxjcF4km7rnhBTI4NRjUs1fUj7ol6CQNJg/fS+zx?=
 =?iso-8859-1?Q?1USpzgxVZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Iew8sy6VasSoHd4hgkIow3vnaxgjugxu0uCcFnc4ffBLh77Fx81X0pD07edh+Gp0qRrhBO5fMCuHwaeZzq6yt7XCL++xrABlsmrxqYlfmCGC6Wmn+SaLYDL4J5kRtxYxMrQ5eNmEcca3WsBCE0AatHuyXy9L4R6GG25nAFR4xbWkByBU154g6gjm/3jjF+h5lxCncrKRBSgrK78wUp3VWtXwVXdxfa+jlAq8A6oqfT/3LLoYfrB0enGt3fBJ8wb6pAvY91uRnW80cVIyqP5jkaYV2QhADLvK3lNCPqRd/2CZb5m7jf6BZoHy6Yk6hZCkZeuHDO4dmy3956eDF2+MDw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5911344b-ac7f-49ee-1243-08de7f6cc8c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:50:33.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVUolakdGUGt+wvD/FEJAEKFfRAgkT7Bt1HgtAENvhYtjNULD1pNMUcAjZ8aoRDJt4/AB2sf+7mmC+NWdSq1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7119
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 06:35:27AM -0800, Chao Gao wrote:
>P-SEAMLDR calls clobber the current VMCS as documented in Intel® Trust
>Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3 [1]:
>
>  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
>  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
>  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
>  instruction.
>
>Save and restore the current VMCS using VMPTRST and VMPTRLD instructions
>to avoid breaking KVM.
>
>Signed-off-by: Chao Gao <chao.gao@intel.com>
>---
>This patch is needed for testing until microcode is updated to preserve
>the current VMCS across P-SEAMLDR calls. Otherwise, if some normal VMs
>are running before TDX Module updates, vmread/vmwrite errors may occur
>immediately after updates.

The agreed approach is to fix the CPU behavior rather than work around the
issue in the kernel. So, I'll include the following patch to handle this
erratum. Please let me know if you have any concerns.

From 04b53e83dc9daee1866e1c8f26e3d027e1a0be6a Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Tue, 10 Mar 2026 18:49:41 -0700
Subject: [PATCH] coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with
 erratum
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:

  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
  instruction.

Clearing the current VMCS behind KVM's back will break KVM.

This erratum is not present when IA32_VMX_BASIC[60] is set. Check for
the erratum and refuse to expose P-SEAMLDR features (e.g., TDX module
updates) on affected CPUs.

== Alternatives ==
Two workarounds were considered but both were rejected:

1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ugly
   assembly code [1] and doesn't play well with #MCE or #NMI if they
   need to use the current VMCS.

2. Move KVM's VMCS tracking logic to the TDX core code, which would break
   the boundary between KVM and the TDX core code [2].

Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]
---
 arch/x86/include/asm/vmx.h            |  1 +
 drivers/virt/coco/tdx-host/tdx-host.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index c85c50019523..d066c50b9051 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -135,6 +135,7 @@
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 #define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
+#define VMX_BASIC_PRESERVE_CURRENT_VMCS		BIT_ULL(60)
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 891cc6a083e0..13c23769d09d 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -12,8 +12,10 @@
 #include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include <asm/seamldr.h>
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 static const struct x86_cpu_id tdx_host_ids[] = {
	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
@@ -175,6 +177,7 @@ static int seamldr_init(struct device *dev)
 {
	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
	struct fw_upload *tdx_fwl;
+	u64 basic_msr;
 
	if (WARN_ON_ONCE(!tdx_sysinfo))
		return -EIO;
@@ -182,6 +185,15 @@ static int seamldr_init(struct device *dev)
	if (!tdx_supports_runtime_update(tdx_sysinfo))
		return 0;
 
+	/*
+	 * Some TDX-capable CPUs have an erratum where the current VMCS may
+	 * be cleared after calling into P-SEAMLDR. Ensure no such erratum
+	 * exists before exposing any P-SEAMLDR functions.
+	 */
+	rdmsrq(MSR_IA32_VMX_BASIC, basic_msr);
+	if (!(basic_msr & VMX_BASIC_PRESERVE_CURRENT_VMCS))
+		return 0;
+
	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
					   &tdx_fw_ops, NULL);
	if (IS_ERR(tdx_fwl))
-- 
2.47.3


