Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8CA59
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094102; cv=fail; b=gtl3S7mwUJc7R78csQb6YJiay7P/un7kuSEq4FYWspeXEyJv+7z1mMx2G4sHw5PdkrzAPAwZAN0oO4/BEfi5EQL9B0SxWqM2OYXAPErxyBcu67U5Ht2EJJlO2c4hlERNHzybThWys+X4tA2WkShrN7IF3gkG12zkJdeNl/8I2HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094102; c=relaxed/simple;
	bh=WJw73XV3gmo+5xQCJu+n6xwR+jkV9bX3xdUoaG3Nls4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=H13HzJ11/fCRddwxZIcIzbXRZCDgCHeAgTsk6nK9XjirU24686LFsu4QZn+fZuvNoEVBFkh5eoGUGSBw5xX2a3B0a8ic9nunnGNb9OjIsc9iEV46BgcjBTXX9ze6wfKtaLIhXBLtIalFFlVgClSs2Y7VveAt5PwZFpxkukjQ204=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHaJnKqV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHaJnKqV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786094099; x=1817630099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WJw73XV3gmo+5xQCJu+n6xwR+jkV9bX3xdUoaG3Nls4=;
  b=nHaJnKqVqHfLdLckurFmGy9/3r62aFb8ZNbn3TfT291x2XOGI0VouHnR
   ovYNGDJ3+Kn/mn5RzJZ/wPb7UIEnY/bOZExVOqAsn2DFrbVaiVpnKj3NJ
   5YY/OiyqcFhybM+UjqYN4UdtUnW9FqQe3Uqww5cASDREL69Z51kjBmYXA
   cnj/geMWTnFBPgxSJdhpwDkgX8pCoPzdjGNnPgqyQobToDf89vqpPADoP
   FcnrhxOCMSrW0xhw7k1rERa3dCmRzfKrjFJHoA21kmDG1UHN5ggviX5/s
   4H3dYbEsd9cvz0OdU/K2G2cQHnTKmpCpMvuSlPi5BA9/zkR6Gcp462JK3
   A==;
X-CSE-ConnectionGUID: kQJrS5yWSAG10LdkBiMZdA==
X-CSE-MsgGUID: iBJPhwweT6anvU6yW5B4DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86463673"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86463673"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 02:14:59 -0700
X-CSE-ConnectionGUID: TOll5zc+QxycvcOenTUYxA==
X-CSE-MsgGUID: gAPQuIO7SCeJUbsbfYsvww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="260575346"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 02:14:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 02:14:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 02:14:58 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 02:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxWqE3t9Lo7ratpIbPtC1hvLFxtZrW+6/pzva9EokbVNAc8akPionQkYGK2IWv6F3Fj8F3OMxGoU0Y3/BE9vTQwde4AIMdZ0MdBZ1qzs4q31x55B7IzLeWtr76iGrtrVmF2qdQbSVtHmPkMuYnrO9hQco4HpFuD6GJYSsXjHUJgPFIoX+qsLQePgFF3Y546hHgfChKM98yMYSoHxG+nbLoh8yMXs8pW6EHeMLePEkX0ECnRoJsNW8G+yX7EjGWYR3vKsljooYUxkXeKgUmTKRezMUgvl0WONt5GH/lkdcLrbEUAFORGRO8qfQm3eLguc90WLt3e/cFO8mUxF/4QFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmvWQPDf0yBJVmCQwPJIF8yl/Bmz/58J5juVXsG1kXI=;
 b=DW3Wkr4nRUBMcykt0Sc4ChCaVcydZKhk3cYjO6hF8E+xClDTP1869TJP11gsFAiAOoEB39WZ53qxJNwYTmP45+5kM4fSj4Sf18D9FZE32iTETZr2NEVXp8HQJAVak7K+9i7QU4lBO4oSMFFFz5tW4u6yyZlQrzWfzuOEoZwRX10YoaOnfOe83hCY14A//xd4WfMdZgmZrbt06ew0gRc4nMMmw+53aKXDDXZrBpJsQv1127tB21JkCQo8NzEAy95Q534Df7cFfE63r3qLv/TtGx75E2PnVjA7J9NSF/NaftOhwOHjuErUijQ3bhTbyzDln9st1t8d4xREGzDV01/8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CY5PR11MB6259.namprd11.prod.outlook.com (2603:10b6:930:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 09:14:55 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 09:14:55 +0000
Date: Fri, 7 Aug 2026 17:14:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: David Matlack <dmatlack@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Sean Christopherson
	<seanjc@google.com>, Josh Hilke <jrhilke@google.com>, <kvm@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [kvm-x86:selftests2] [KVM]  a262fc49e0: kselftests.kvm.make.fail
Message-ID: <202608071656.86e9fd06-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CY5PR11MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8f130c-1d80-41bc-e733-08def4645872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|10067099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: z6Orsg3qrhUrnzK7kZdcChLGMCncigu6wM7ihWpE9kInLtrZ/dD+CPH6Wcpuix77S9QoB6dhJvAq9cJJJGfxRZTW0f9+w9X/CLpgCtc4zq2Njmy3v+C1+rsktwLXsz9jyOn93SKWijYIzwdGBak980LjVTFYxKDHid87vjqE1mod7MGdSMcxcWF2g/Dd/ner6kY2XhOys/z7Brc7VoeLHYYbbgtnup+4cvMDtM1s0iekQICyJUF3XV0l7E+x+RQxNxLGZSLWsTOz+UdG55HfXDUp0bZaSckIiAXaB3ycp0Ep7kD8Jp4038/a/j7UgF8z2cH3TTPwS9gicmpOWY80/GsPyDcu2+kzXNmawJCKPwkvxDUVUQqrMER1TYZgtheWI4WxikSkKlSpDiENoQIX9mrEFRwGnsej+YPuMJS7H08NBJTbUHINHEX3ThR7diftPH7hcHo5CPF1TFfZ/jGpz95A2AWycyt5muOj7elAKy+NSD5wVy1ZTXjsuJ5QqFfiPyrVjV/Z3L+YzY0MeDSsm9XwaielCAXXZVocjBF0OWPodaNyQdT+PkAFO+khMv32cuuAojmLnzToicl8vZAebVOZzBG78l/8fOr0Fh+Dzu2dhTyrJsDEfXPhNYG2nfPJqepPhGFXgI7ATpmaEUpc+y1LXQc8qGr26ru0uGuI9oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(10067099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/3c4x3zlivWumSdsrCzMG4652OA4BDOhRGqBFiLb3JoMXLtB0weBTeU4h3t?=
 =?us-ascii?Q?1qZyIUYIQEcTvk0B9cv7OXCjTmDuBe1h2gd8l1WhmH08I0aUPtK9Uk9Bm8e3?=
 =?us-ascii?Q?TUEJ41IlXOkKUs6CsZEfBptqNmnnrNFq5nw8LEZicBcOdbfanngI3h1DOuiP?=
 =?us-ascii?Q?1S51c3JW9dhf/bsiX3gGZDv10cNudJ5mbukQ1aMvIk3u+JnaVZGecFPBsGdv?=
 =?us-ascii?Q?Vnpe9bkvMALjZvLknj4pM+8L4sHUxWFsWh5sexbmEu2LvliqiTrAR28S6TUU?=
 =?us-ascii?Q?qAyVbsq3mR80ekfslnwxfshNZRjBkta9krNTywKHlXOyx7LPIExALc9VU6ic?=
 =?us-ascii?Q?O3RtSGbgXeAEansQKbnnNJlhhIz2kEBEjvwmBNeUfx6iQ7ySaoqBlIDl0lMY?=
 =?us-ascii?Q?1TnqutC8ou4jbJr6yAzrQZPmlodCSwaQPCMp5dFEmOMvX0BM2l81GOwRYd2p?=
 =?us-ascii?Q?0vc6dGNg61DvLgPcL8rnM1vMUTTLrTyV1CyaQzX15F/cEh6R5NX9HCOWYfou?=
 =?us-ascii?Q?ebOEIp+ciSWVFvCU9U0/96EmAuUVo4BY596MirtC1YrRRRJSh4AXI3Z8NCBg?=
 =?us-ascii?Q?Z9hW/WDAIpAaa6CQKOB9SBqVNNV15XmZamykXD03dnA40e3SPy14BnnBblxy?=
 =?us-ascii?Q?t2MTmUuwy6smi+QDGKkG/edT3NmIO/MPDMLDznbUZamMM4jAKQbP7tTYhyfv?=
 =?us-ascii?Q?ChoHSKbrR45rS24f+86Z/Ipu/ERO29+I0e1Tuoj7yyfZkCs/BbXLRJdTn412?=
 =?us-ascii?Q?cnKOjlUvVJLifql19/YU1mHvkQ62RRiGtkx/Y+kLhUoGTnUFGRxka/WD9NtX?=
 =?us-ascii?Q?m5DNsnZ6/7LN2VSkYUcYIjCuyYm1GMu2e7ykOdwFyU9iRfQYzHJ3wBI67lam?=
 =?us-ascii?Q?iRaHcLAahiuqkw6ex7NGMRsWtLRYFTRracANNMBP0+v9J81MaYZlJDL7MtQi?=
 =?us-ascii?Q?zhpuv+ihIeU5QPzpzYGWJ6DxxRTMu2ynKMCz4KURAO2ApbK0TZniiCjhYiBf?=
 =?us-ascii?Q?ReIW1i5XNysppPwnInBu79Y5eyNL36Neu4apDBXwa77h8BMIkpIK6gPBpIcF?=
 =?us-ascii?Q?jg0iXKl8C3MQjFHKhaYCgj3BLMi7X5RLDNtD8G8LpXZaFqYD5RP7WjRwQb0/?=
 =?us-ascii?Q?dhZJrDgH6QTnBYPo5iiK0hkEqASInNptocGrEhaV1CfiVbjArI4E/uNGrEb7?=
 =?us-ascii?Q?+ZSrrUVrPSXfEmyvylw7LFH80YeaAfXysGmBKkx2EfhRckZGHKXvkoSGyHGd?=
 =?us-ascii?Q?/SZLvJw1tL/k3IGI3zHRIWvk+YTDkfvMKZMvZdaabEdVJLnUXJrBEWw/dDzF?=
 =?us-ascii?Q?tLhhFe/m6vkyHsbT6Bx5p51+1GoqUfZ553N4PoWmHWsrBs9ZeL3A0BLzUSHC?=
 =?us-ascii?Q?ZxvcR4eMWMWwaz8AyoaiEi/NBLf44mHhFqa2EzrmxgOFAUGbNvYe11N7eKII?=
 =?us-ascii?Q?z/8IkQ8I5mN9YBToLKNpj46nk4ewliAJ787b5ZGhw1tuD1Gml1LRHRGBiN42?=
 =?us-ascii?Q?awF++0MkjJzJiuCivW1JET+6BGkarxklExPCBQCrNEezHlnWzEpKc7O+2eWP?=
 =?us-ascii?Q?R9kJaw7TBZndq52a5gLq4auXzGn/giLJP+a0eNDCu4Wl/aoE49c2RuW5ieXX?=
 =?us-ascii?Q?WgLPj12PHqx27wzwF8PBQEmhdOLPRwRxmVpOcLL7nElc71/pVEGXKvIcq8Ib?=
 =?us-ascii?Q?LWaeKgwDymxHOBoEX8WTrTWi4re7cQA5+FB5vxh49n2jnUQ53jksR7uRgTcn?=
 =?us-ascii?Q?qpjX1hoHYA=3D=3D?=
X-Exchange-RoutingPolicyChecked: El/dZ2DcWjHNruimxGNOE52Z+rXlRUmw4ZUrPWDjHubxKzMtC9J5S+0SqL9TuHVnrtix7TlvSZrYzqiMAk8H/nP97Kb4iV5eQcO75WtMnRd5O8TAo8bMMwKr/Y5JFb2fsd+14RxjWrVuvtCFVFB9a72fYWREBL4cl6LBlsYLfejkRIJZvBLIWzIwblnBuME0bFE6op78WRe1cXEDTTo306DNZVjYftd6LeEAjJz6js5ZNgTG83QjlRPG767+aG3G/L1rXdpGvLNCrcUGgtFYs2oIC3iINHXPH1v9Wo/P5UKOPrjkwpLKYqcMV82tZCz3pvfruBSxqXRfV9jvm35TyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8f130c-1d80-41bc-e733-08def4645872
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 09:14:55.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5qBei/CjosSVnMvm90Z0zHA0UNxtutyEgT8JL0oswR7LexhiqhyQSd2eNjNyY6KvWZgN6uaudwfJaTVzcH4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6259
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kselftests.kvm.make.fail" on:

commit: a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757 ("KVM: selftests: Build and link selftests/vfio/lib into KVM selftests")
https://github.com/kvm-x86/linux selftests2

[test failed on linux-next/master 78bc8af4affb9a732504eb22eeac7d1e50883853]

in testcase: kselftests
version: kselftests-x86_64-848acc8ffe1b-1_20260804
with following parameters:

	group: kvm


config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202608071656.86e9fd06-lkp@intel.com


/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c:12:10: fatal error: hw.h: No such file or directory
   12 | #include "hw.h"
      |          ^~~~~~
compilation terminated.
make[1]: *** [../vfio/lib/libvfio.mk:32: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/ioat/ioat.o] Error 1
make[1]: *** Waiting for unfinished jobs....
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c:14:10: fatal error: registers.h: No such file or directory
   14 | #include "registers.h"
      |          ^~~~~~~~~~~~~
compilation terminated.
make[1]: *** [../vfio/lib/libvfio.mk:32: /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm/libvfio/drivers/dsa/dsa.o] Error 1
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-a262fc49e0aafdeeb1b4fd8cb0d79a0fde447757/tools/testing/selftests/kvm'
make: *** [Makefile:218: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260807/202608071656.86e9fd06-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

