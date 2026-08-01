Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CC1C84A2;
	Sat,  1 Aug 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599774; cv=fail; b=spiNVR5Hr8I2/YBeNLq6hKUIYnamHKeNS1zXtI/qAaI28pWxGBq/5e0fSYC/vFvNqppOIu1ij8lBMybczPpnf6jUhIevKXJsjJl9G2qStpHAq4gEUezopTZeJpQmcbRp2rhvI+ht3/1BiVTH0CMXHCkXqmKYKCE6+w8BvBgQwpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599774; c=relaxed/simple;
	bh=oO2uT0QDzLY10jrAw3bRv3BFPejZTBpLclrrJReumlQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kXCWBQMmOih2aCkwZtFTQc4Nw3Up3ecBa8Vt4FkJqaDCNmUgF4J5law9fryO2P/jTFbvVxOZtADFDYMaAaayPL4ps8viTAuL6e+4ywR8+5kekzNyrYOdFZYn5mQ7+zGOb4OyttKoUm5CvpJSzyhntVPGLgO1MTRWm3BCdjoyaaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYaSJnRQ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYaSJnRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785599773; x=1817135773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oO2uT0QDzLY10jrAw3bRv3BFPejZTBpLclrrJReumlQ=;
  b=QYaSJnRQd7BG3BdHzo5EnEnr7iiLdbN5iEKRDwV71/X2K3aIEBNigk08
   lCNWC1K6JTG+/2cksMgyh5XpKC/s13pt6iWnK8AYx+A3mn++gdqXusHO2
   UtgFByMM3yClgFNlZ1FxhVTLi6rz0kEPXNh44+ttKZ4F0tN94DGs+3q6L
   xm0uSeo9gN2CUsSTfP4JyTX6RXGpc5MU16a66/2e/6mwwhmA1kU/l5DUg
   ALZTsW5KdxlwW/2mXrJAVaweaJKxivI+VxP8IeEp5be0KD3pW4dy4I4JO
   4pIfrbVesAaC4VRb7WFNjVSX03zgs6LosGYizc8NfFOKVy8kuaYSdgbbG
   Q==;
X-CSE-ConnectionGUID: 4fTbA85ZTfWnhAxc1fBFGw==
X-CSE-MsgGUID: DIbuF3e4QD68xCuDPmb/OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="90015973"
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; 
   d="scan'208";a="90015973"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 08:56:12 -0700
X-CSE-ConnectionGUID: RJVLuy2bSVORkSf7I+FWJw==
X-CSE-MsgGUID: Kgkeh+gwSzarD9zAT+wHRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; 
   d="scan'208";a="254549607"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 08:56:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 08:56:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sat, 1 Aug 2026 08:56:11 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 08:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFVv647hj3+a9HV8WUFCQ+bH180Qja6Pky0EmcFg1QmAouVtWNRP+V8WCSrD/ZVG5166nvMbQrbo6a+Cc/s/dHnE2nKVc3lUU7JSM6ws7gJKjWmPi1gfZ7VRE/KvojzBlXaytKNmB9UlPHTQW68VQ77Y9zhE9ZoOQ+QU72Kbg74tMjLiTXlIxpZf6Z1PGBHfctbFApT06S79aIN23p5ouu5fJKVueoLI3jXpWnfO4t9Kv6RqeAFFD3QzXrjhVUwASh5hrDm4a65VnKTDLadYxL+eYG26lVDEmn+1sDfd8sI7q/nrx6M5cNdZHQTaJNK8zfcpo2HQzmZnEPTytXXZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuiZVROntaJfXwaa96mgxAsVelUvYRRbgfXoTDIRVDY=;
 b=INORMDtD5+n+THh4lg4n/z2BLpmsHi0+zJof7SK+L/58fAtmdTzRijd/gK6oWEg5sV5annTXJ9bM1SmlqlyJIHPFFFKKa8gVZO+fUvAVOX2d65JuwM7PYFMoPlS0Y8l+KxI+0CRaQ7+uKFBEQsw0raYOoh9c0IZgilwnvSQN50fvQgVFO00zpRAWuTe1BgU4mksVesfNnSqf94igzcqtU5+xzzGuxdGmqAZyrQpcf8fs6lsBGwo7x2cC3ZXVaq0xTC0bQVFBpg90LJ64Df/Bt1ETdwva31cdV4Z5S+nou3Iwty56ncd0pplyxkit1Cf41AeDpNPQcvpGKPPZ7lqJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 15:56:09 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 15:56:09 +0000
Date: Sat, 1 Aug 2026 23:56:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Courbot <gnurou@gmail.com>
CC: <oe-kbuild-all@lists.linux.dev>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Brian Daniels
	<briandaniels@google.com>
Subject: [mst-vhost:linux-next 16/73] error:
 include/uapi/linux/virtio_media.h: missing "WITH Linux-syscall-note" for
 SPDX-License-Identifier
Message-ID: <am4XELmDW61Z0AbX@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TP0P295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::12) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|MW4PR11MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4746f721-1a0a-4f70-6f21-08deefe5670b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: XRG43LmHP7gETszEBEWXGUsOMftce9ghs7fy9FQJND1j1T9yxrpxlvEn8fOWuYAF1urEwCAgCy1MCr0Q2UIBNyOciBI91pqJRzjMhss5DOFhcDyYXIKzUfd/2tf1xRnr2XDFt/wvr2e0VAv28XJeqKdxVSaTGBdNa4vWTPZ6z7QRDYSSN0QJck7ZRwlgJFoGASqVbBik/dPkHO+UgPK2DYAqMTFTZ1yhs42kVKXxMY8hIEo4p0aDi/4+lK4l4sLifmMZGTBSr4wry2BbiEyKpVcSWoqGiVL8eyOn+R2R7unn+boMfl8U/nd/UQ92MMfZ8Yb2G3tjdxzRNxgcPHrpA3DvH5DgcB48W+9kv+f3Yk9kLiwYZOjUoakp5L6bCiH2L/eYgwLX/W8O95jXjqu69ryd3jsM172YWnrhwZ3zNTbQv72XUdJO0kQ0jdWY9JxGmjKi4mdYLePtQAy91a2WfTuQD/+LfYDndUepFwKENVjao1Dy1GrkDQUcnGJKvWmfBPef7kh0ASPOppTvFfdIArQyWqBZa19fWmYpgvwaJAqz+GccFdo3rjxoPr3RZLmopGu2/23BWhrYarZhe1Fa9kJSuZskV1s/nJj5dmizTMxhVOUqiOL8d0S1FuUeobbgUQ51zwiNWMgMoTAfnX1MweSFXHNwU2Q+3CF0O0gKvTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqar1IhF/2XQFU0aXTD4GnTX3oorbiJcvM/gZ4y6j/8KFlHJgMWkBSQp/kFi?=
 =?us-ascii?Q?Frbi4t6iFWAqO5vAyzv1wocu/Zmmo8CxCLaX2cYgvArOGNoEj1bYcHoSEkxZ?=
 =?us-ascii?Q?r/CzlSP+LPZpgU3eVSx0cSFUWyXSl2BF8kcVpHE1SWugN5ZHOc/lIWhv7qcR?=
 =?us-ascii?Q?D7Mi0Ka/SCLDsV0HSO6g2X1akWnRDT+u/zRcy9uZ2hvVODnvT69MA87E3TyL?=
 =?us-ascii?Q?dAncFhoo03bqcREmCwIU3XXNSQrBoh6cNh+YSnLIAoIUaJuXV3scgyCRWs5p?=
 =?us-ascii?Q?pgneL3jDIby3s56NzzHgp9dgx2AnwpNKZxXS/QjHdN4Z3a3qgjF30RRMZ0WJ?=
 =?us-ascii?Q?s+e24UDFPF+q9MC4o5OVwb2qm63X0LXlIdStyTEcH+ZB/EKDShtOJHAz2E09?=
 =?us-ascii?Q?jyg2p/WhKe2Yn5K5vGqLAqA1zLTbF0z4qOQqx/AFntCvkVaQP/khioZuwme6?=
 =?us-ascii?Q?ubaFNXL9keFMHLJtwc840nPn6Enm48r0lh3pV4NFSFNSigE+2UN+mHkxiNwz?=
 =?us-ascii?Q?ltpNeVX0s1WebwVhE3vm9/bFgP8ualbdJABZJ0Y/MOPRFT1EjwZtVFkeXmIt?=
 =?us-ascii?Q?njUAiGhjoC3mBlnCXR1Kl/Ddnc9QuNO+2S37UIU8UYDOfNRYaTK9wvpU/DAZ?=
 =?us-ascii?Q?/H9//QPgvuo22VH4bYoPpPlN7gxTucF3uftLj65GWZOCWMjOGo+VYsFerAmc?=
 =?us-ascii?Q?8p0hut3n4R7p80clevpql7Y/t8rVnsoaFAgATpv5ER53bEMW9NL/T1qZ9skH?=
 =?us-ascii?Q?gozP+qIn7Abyh48vxDowyzKRMb1ts5OqVTfn9xOZ/FNX9bfqojLl1WM8Ykl0?=
 =?us-ascii?Q?r0AuHBRloeQAinpQJltLRFcf/0k/1xwlPDM6g7sjbJ9DIpsxA1QvgThiPgVc?=
 =?us-ascii?Q?toOtfxxLZ9pvMBV9z/Gpv6gjBAP0nAcfxS3q47yPEQ8oyijKHblHNuqTdomK?=
 =?us-ascii?Q?inqg7cCbC9NXURuaKXWSVQhMuikXlsmgH++q2l2/4egnAiz8Ldguu6thalOf?=
 =?us-ascii?Q?Xn6vAI8oqU80jKl2FOJVeWpmCgYW2VSI73ZKehc6Z5LPBLE3Fb9xdJk2sWfO?=
 =?us-ascii?Q?ymvG77ZnU947KtbOqfQNlY0g3aYKYUDZ4gUkcILU+GhSJu0P7w7n8eEHso1j?=
 =?us-ascii?Q?HIvaa19Y6/BGs5kDTu/XZOOQx+pUm60h+fah6J3AFZBnh/LFsvgx0qhVH5AS?=
 =?us-ascii?Q?leQGA4psr14iF2jXLb0xaLo+JYUuLxLZ3VzCk+hVXY2k7Nq1ILj7wYlEyXMG?=
 =?us-ascii?Q?FE0aAWhCqYzAOH6YBouBZNTnStjcBW94+SYY0x4tdDSGZ1abFzOfcPe7qfli?=
 =?us-ascii?Q?PE19w7bdWjByiivOdHDsSe+eI695S3pFzzc8txBw8OCkjDIZu4TiZSgj1nVm?=
 =?us-ascii?Q?I2/aYKRljyxjEezb4zLhNogSEnrWHYk6lCYZEyTZgNRyzxkp03nzG5yo6TRJ?=
 =?us-ascii?Q?NZ3baPg+pncpnL0+es1bAvqEXx2hpx/kiRMMvZHwnEEiU3+6IGUViy4LuB2N?=
 =?us-ascii?Q?Q6NNR52k/+y3/RgID4ld1+IQDKKYLuB8kStidzfBF9EcQXy46RTUc7NBqke1?=
 =?us-ascii?Q?I4I++/3ZBrP8qME4Vxe+W9stZIfHr5MddTv6GIRkt7RBXWNsoQijmoCL0WYH?=
 =?us-ascii?Q?NOZ5QYQX91MSEf7Qu19X+Fk2tyJvwAdnrnF+H9KSB8lNkauDbjzp46JPjo6C?=
 =?us-ascii?Q?GcQ9v8vlRHxRpKM2Ns959hUKulnrnGeBK9X8PbgYjDDdk0xMF0vovr44ocV9?=
 =?us-ascii?Q?6tQjjRKyuA=3D=3D?=
X-Exchange-RoutingPolicyChecked: CiryyCr1+m4evAsa0w5bUz8j9m0r4O4c7FUSW01ZgPLXEuSk9qzj+AGHYjavHVYNRMVwsxM3YcyrbrXilgR/Tbua2qsQC2lCRI4uazI00oK2c2Ci94Y2uNoXHPTazBNMS5XRw7ga/ogWwithVbr6DZzxBzcpVTczyTRFjwAvp3cW6+q6d4GX3zg7HvsCvZqafDFa38TPH2abOXK/ckLw0qUHz+jFlQYzBIC4DzFm3t3uw/cFv9R0DDQY+uOrTftdg0X3Amz41Ztf2EKmPSYJqAgyCMtLn3at9J1VhFbNue9q+xrZsQOfDa/RSc0f/G7BJC5OSSCgAthry6iv9Q3coQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4746f721-1a0a-4f70-6f21-08deefe5670b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 15:56:09.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOfVvkghyQc8cozVzOiDESi2zuAgVQc4tP0OMOYiXSWQ4K6HYatvH8Zl1sqKYMK0vFNteOrm1hMzuX8Gjdw87g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
head:   a8a2a266a5d6d5a9e839422eea6ba3986e25801b
commit: cbd7147ab405921843903c72ff7b7e2066d9ba78 [16/73] media: virtio: Add skeleton virtio-media driver
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260731/202607311159.8BW3pzbL-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260731/202607311159.8BW3pzbL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202607311159.8BW3pzbL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/uapi/linux/virtio_media.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
--
>> s390/cpumodel_subfuncs_test.c:266:30: error: 'struct kvm_s390_vm_cpu_subfunc' has no member named 'pfcr'
     266 |         { "PFCR", cpu_subfunc.pfcr, sizeof(cpu_subfunc.pfcr), test_pfcr_asm_block, 201 },
         |                              ^
   s390/cpumodel_subfuncs_test.c:266:55: error: 'struct kvm_s390_vm_cpu_subfunc' has no member named 'pfcr'
     266 |         { "PFCR", cpu_subfunc.pfcr, sizeof(cpu_subfunc.pfcr), test_pfcr_asm_block, 201 },
         |                                                       ^
   cc1: note: unrecognized command-line option '-Wno-gnu-variable-sized-type-not-at-end' may have been intended to silence earlier diagnostics

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

