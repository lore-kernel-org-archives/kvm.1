Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF0B3EBF3B;
	Thu, 27 Aug 2026 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822411; cv=fail; b=DOuDD9625FUL1xtOW0sbWlwxEBJNsEEHii4/L6eidyVgYqW1NgzZOtEANkcEECfPyhmydunXDgm6n+pnBppZh4s0cDrKL3KXrp2oJTmS6umH74vB40+6L2Xo98bg2zU8MvOf3+rf/yY16nNIsFReXLqJgN8vigUfz0fi9lb9Kv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822411; c=relaxed/simple;
	bh=QQJoMgYWjVXyKP/Ysj9GLKxilLeNoqUsXoAMaRb9aJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dJFTpvfVGwTtQsfqWCaqRTKbGoL68MO4g3Pe993l0Gsi3G/IINjXHBF/LMStmGyJHDcrAXzivA8ylE4hyAH6Gw0LlvUCebF/VL8J5pOkR12rqL5H1iUi5lV7G4D4NO4BTsD6dRV9i+ulFHSSKc2maWIZA8+KdcoMus3pjIpw5RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/A1Ixw3; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/A1Ixw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787822403; x=1819358403;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QQJoMgYWjVXyKP/Ysj9GLKxilLeNoqUsXoAMaRb9aJs=;
  b=a/A1Ixw3aegkXU/5AzgPzA+dQrWBWmwfsueSY5OIv3VM/sJxdEnr8eR7
   S/ENZlAgovmDRrhuczFG5LIkA3u8ygGxajvFrod0tmYsNLPR23C0TDfzD
   u8agS1IeM71Z7N26In8rUcbio7vInnT48hXZlbqZ3bDjvDzkrzr0VtQaD
   dEqtS0BO5oqiChv5Njh66IMnp5o2ZEDE993Z/h7fr1rLGaVUhf969Shnf
   Tfwz0yYRqCRjMJwvIXPbbCJQlz0EUtn8UsOGnKZbYWzy3wKglIurJ8L4t
   V51EEll6RJP9+S2dNay9T2CX81XvmbDO8fFw/Lqa1R0fuuBAvM5rPcdi7
   A==;
X-CSE-ConnectionGUID: VVgD1OtISnagyHGVfjnSBA==
X-CSE-MsgGUID: Dq0RkZYyR4G1GhQZb2lYhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="92134426"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="92134426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 02:19:59 -0700
X-CSE-ConnectionGUID: 8j1ggn65S9CEK7HQxOWGmQ==
X-CSE-MsgGUID: ImVMRxhhSFaA0l3vyfJBBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="269766572"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 02:19:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 02:19:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 02:19:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 02:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSR/36a7FJ0t8/F/pKzoxF6RlLQqp2mWCqwj5nN/hka8u69PnRsrNTF7Ayei7T2i2K2BuzSdrWamx8c9jTmxgTb6TR55mDXR2jwMCBrayJb6QHCCqM0vmVcuoQVkakjnmzmTVgHwlk43nMGq96X2WlSNP88s3LT9WNONh0JflCujZIJ9jHo1gAZeH6o5xXdYqtGlrBURkAT99RP89C7fxu8izmn/YdBU2k+Cf/wmG1LWdVJDkPNNntO6RikQNQ1A4FZg0V3cDZi44NNDpqcpw+nlYAFWxuNbJkTHFi3R24C1VKwWwcJxYY3BQABXAM6M6YVYSImLckymzTQaKMGzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNxY8gAfVKsBY3xoSKHZ6hMJ2O8L/6u3uLCAfMAc33E=;
 b=xaR2Cizd7SR5qIGIeBnb33AnQZxWsiar5MDcOgPKZtVaku77ZaI4i0BxSiBlWn7gJ2HyKleCmtO2m09xVLnFCCVff7zgloCkwEjs0Zs4RfpgfXG/kuZtiaywqwT8v5gRa7P/D+I/PxPA+KconV+/1UDzKMqMmYc7yMSfNwM61m9kqNJ0yFscuXbZJaJK+Buq/1zFer5RnN//ipIusIfNlty/yhUezgtIVe+BCeoqx7tFV/I/9KJWnHdFCEOXWE/urrDQws7w1X+9P2GTDajuFi+1wDfBETGc2DCdS1USPjIhsNIw+yROCg+RKkNJFeY1eWhtGRGtC4+JM79QpMVqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8) by CH3PR11MB8562.namprd11.prod.outlook.com
 (2603:10b6:610:1b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:19:51 +0000
Received: from CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd]) by CH3PR11MB435924.namprd11.prod.outlook.com
 ([fe80::1696:c90e:60af:a0cd%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:19:50 +0000
Date: Thu, 27 Aug 2026 02:19:47 -0700
From: Peter Fang <peter.fang@intel.com>
To: Lisa Wang <wyihan@google.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng
	<ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, Ira Weiny
	<ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, "Kiryl
 Shutsemau" <kas@kernel.org>, <linux-kselftest@vger.kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, Ryan Afranji
	<afranji@google.com>, Sagi Shahar <sagis@google.com>, Sean Christopherson
	<seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li
	<xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds
	<jmcrey@google.com>, <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v14 20/22] KVM: selftests: Implement MMIO WRITE for the
 TDX VM
Message-ID: <20260827091947.GD33657@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-20-15ad654a50db@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722-tdx-selftests-v14-20-15ad654a50db@google.com>
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To CH3PR11MB435924.namprd11.prod.outlook.com
 (2603:10b6:610:34a::8)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB435924:EE_|CH3PR11MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 794662fc-a8f8-43fa-8b39-08df041c58dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|6133799003|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dc9Z3N/zEsuPH0G2BlmxZxICT2gpkOVStomqXjRhj1xR10qdqGpxudVU4lTR1VwgTkbXe6UH0+0gwwgs3nn2aeXOhGBFzXboqat0hQMoqjj5HCzZtpsJ4NpZatBQ4kLHBdX9NkgSal4FDWIBC+qoh7LBdfGBMptM7EhvsIhlUpnKY2OeFkQBYcsJTyl/1LjfFKDn4HAAt9qnSBv+rrPeNUI3Udgg8Kt2mr5g6jMVzYrh8tnRLMfgZfk8OVi0naD45E6KEF8PDqFYZT9PAjS9XYInyc+2UyPuRyf2hILSeCacldWT8QV0B8o04eMHAAYIvRKyynmbzB9lpBxy+1F7NLJR/QhonidJmcCPaKpf3sHGs1RMlPzdKHelQFV9dZ7osgO64t/5rhTpLOkrwrdAB4VJ5kVLtioy2PRjvd3piKnt3uuXY3D244fIRHTFb1tLzXSmo079Fl1OZWj9bYXUX8Hf7zSJijcEMb/v/k/o216JNEm1xLpLEJi6A+epfLAR+kaHHkdT3iVwT0uCLFaewNZzbii725o9chWhjIgU2qQ1sJsu0b0TIecfjYR1tKdWVUuumxAVAaK2NOSN0NvLYlBbv44L8ENIj4Ig/KnTZaFMYjsmUI9DvZSQ2qAWKo+aFAxELRy2nCEgcHdOcXuZ8FKxOQfeeIsfK/ixsrLQDMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB435924.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mo5saedK/zPnArUcyDKmdxzRqjj2U6RI2TbjPQvCWgIoHHuPfig+EQPUH098?=
 =?us-ascii?Q?CyBRyal9EUZ6rbnopKs/Hf7j+tIfthm/3Tk2OOsGYuVVGPLC2RqVPh287Foo?=
 =?us-ascii?Q?KcFwQK712hRhKrFElzmOzY029WlbmwGm73CSnSHuPTeXaj8LvT8x+uUlI+vH?=
 =?us-ascii?Q?+2NwwgMTKKNFKyly8gBHfrh3T7osB2HFfgas8dED6gyOaV0k8UYarc1zjt3q?=
 =?us-ascii?Q?cmFlJG5d4X2IKj1p2oobvXMNpgXfzv1If+Ch2p/+dmz6DtWPA5Atmc7imInr?=
 =?us-ascii?Q?4HBkyF0E0hMqEmnqD9d6Lbfr+RLJTuZxiArYFNmekLC1ck3y52WG/UgLTAYQ?=
 =?us-ascii?Q?11E0IgHYa7T9PFffB7NbeNYRu2ONz/rhZ1qrx3yfASyN9bN684j4YPKZU2hj?=
 =?us-ascii?Q?dwClC7rLWqmCmoldRfPJvl2bzJ76jMgq6KaVxJcLbhywgN+jkwp0jWByY3ef?=
 =?us-ascii?Q?a2Vai/I0aazvjSW7vm6hjmcRwDzlqeYp16TIrJ4EbgyQCSvZbQdh0fd4mp1p?=
 =?us-ascii?Q?0UTsKrqn6KuzihWFKHSAFID1utuWXs7dMCLu6Fdzuq5sG4mWtXnb4Fsy2vfA?=
 =?us-ascii?Q?57PxhJuGNfVQbTENwcS8UoXp/CHLQOjqtYLKt0vmCwHITpBhq2NMAuE2lxYM?=
 =?us-ascii?Q?ZKwCKyi3tLF9ZI31NQ28ySLUFlY7En+Fa1o762jh3t8j3Oq3oPDj9dPZyEiM?=
 =?us-ascii?Q?BhnOY6c8ROQvxZX33ZWkZho97b+zwMmh/wD+lLgpsTX2T1UY/277V8I9APgZ?=
 =?us-ascii?Q?1zH3IpWGjdLPMDvd2fN+8hxZB3gEV2n8LbFhWqvyStTuYA0JiSSToJAh3J0H?=
 =?us-ascii?Q?L5+GrJ2V01V1YdPG9rz/T7l1LpMAWFiDw0MDJ2M/Td4wmAmY/gRWNFgOEUPV?=
 =?us-ascii?Q?wON8F8kLi/MNYdB7Qr9t8eY/YfTL0Bc5nC6nc4bFIgvk94PjG2vcEJrX630K?=
 =?us-ascii?Q?9Jm+N4eTNbbn85c/gLcpv9dArcTZi8wOUP3u9aoHxfKJC6xo3SR6Lgb3EK+T?=
 =?us-ascii?Q?oeDu7KzPyUx3Y0mg3gptufitch+Bu5OGwsOyhzEe+SA1mgg+rFpmpZn21/s3?=
 =?us-ascii?Q?w4a0UtL0e+ha1M2M/DJQqyKFh6+w3Ri92oEpWDsRQrI0AZJpIo960k6Tg8ua?=
 =?us-ascii?Q?l2fgKHo0rO+LhQ7hfz7QteqN0VIbvanr9qtwkYeznRDUGikQErsoohBP9sNF?=
 =?us-ascii?Q?JLLvMbBV4CC10ZWFgn4W+HPUxbBjVlts89+n4FibP5yazRy4I45qJad2QGTo?=
 =?us-ascii?Q?lrmby3uTJ4LQEUo1isVaIeYfOSbPflP7V3fYSuS7WrfzNLMj4nooJLoATynq?=
 =?us-ascii?Q?yXuyFcZOnzEFYBZ3zciulGiM9Ovl16FI1x9w7o6okzhdSwVQ8fA05aem1gP1?=
 =?us-ascii?Q?89mzKEY8Ng9hBDM5h0GNR7tUa2bS4vo6t62K5KYnB9cSHFN5RShTunuZ9nRn?=
 =?us-ascii?Q?Q+RGZRbukH/tyS9LL4YdWDB55ts2/ccUMmrdtP9Zq/oazdVu0+udFIO0vusJ?=
 =?us-ascii?Q?pbTZcOEzbRAVgguPRIwhG8ZrDr3N6jY9jqfhQGLKaX/wtyS/KGjU4yhRUxAS?=
 =?us-ascii?Q?94Rsj94a5QKEF7jRZ5AlVSDbpADaaJrBbY/m2MTYIiqlBVYz7gIaKRoCDsCg?=
 =?us-ascii?Q?H/yNBewd1QP9ySeqi19nsbS8dapBLzL5xD1ZJIwj6rZx5FTGqqcClIUn3YJy?=
 =?us-ascii?Q?mPSSGFoXqVp8xVnG+GCNlA9XZX5JMSDGOvMrQXkgDPRC7SXiIH0J17d4RhmH?=
 =?us-ascii?Q?hF1SURvIqQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: DJfB8WtJ2qsRa8QwUOqbVT8ma+dHMFGWVUytpA0R7SOxxr5jvUQCgVur2fH1vgxTlsS9mRzRgrlBwWBDXMO8JeENxxN6ltliDzigfCaKP/k73cPXxHPNoHSoDXUvPtsXkAk3JxI7EQzC5BFRC0JUEaeCMDYZz6H76i1ZpBEIYGfgX7ZXKY1XhLfh3XvGLruM8HJevf/nVFPqNNSxXADCW9sjAO7OngrYNZUhvyOOt2ydDX1wIoOOIjD9VP1eDanavJsOalT7c5jexsN34zdqOUxavlZf2puH6mX3HekIM0Pkz67O+UP3crDS2ZZFCun9qcksgCuuHKONU5e+yLmbXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 794662fc-a8f8-43fa-8b39-08df041c58dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB435924.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:19:50.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30mpXjaAyoeXLqrfVMZGjUYpLPWGvy2De9iL2dVUhgUUzLgU20aj4v5eWvq0hdYjllPSjsZDyAYMvMAKlfprkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8562
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 11:13:25PM +0000, Lisa Wang wrote:
> From: Erdem Aktas <erdemaktas@google.com>
> 
> Implement the tdx_mmio_write() to allow TDX VMs to request MMIO
> emulation.
> 
> Follow the Intel Guest-Hypervisor Communication Interface (GHCI) spec
> to the minimum extent that a spec-abiding TDX module will pass the
> request to KVM. Skip implementing the #VE handler as described in the
> GHCI spec to reduce selftests dependency.
> 
> To perform emulated I/O, VMs use the TDG.VP.VMCALL instruction to
> request MMIO.
> 

[ ... ]

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> new file mode 100644
> index 000000000000..6355a30bb47f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTEST_KVM_TDX_TDX_H
> +#define SELFTEST_KVM_TDX_TDX_H
> +
> +#include <linux/types.h>
> +
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO    48
> +#define TDVMCALL_MMIO_WRITE		  1

The indentation in these two lines is off. 

> +
> +u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15);

As Xiaoyao already pointed out, this function name is misleading. This
is a TDG.VP.VMCALL (or a TDVMCALL), and r11 is a subfunction (the guest
kernel simply calls it "fn").

> +
> +.globl __tdcall
> +/*
> + * u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15)
> + */
> +__tdcall:
> +	push %r12
> +	push %r13
> +	push %r14
> +	push %r15
> +
> +	/* Map C ABI fast arguments to TDX GHCI payload registers */
> +	/* RDI=leaf, RSI=r12, RDX=r13, RCX=r14, R8=r15 */

[ ... ]

> +
> +	pop %r15
> +	pop %r14
> +	pop %r13
> +	pop %r12
> +	ret

This is probably more of a nit... td_boot.S has:

  .section .note.GNU-stack,"",%progbits

...to disable executable stack. 

> 
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
