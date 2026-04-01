Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D5A23D7DF;
	Wed,  1 Apr 2026 07:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029824; cv=fail; b=q6v5CY0VEUifmcbvnb/6068L+35eee9mJzG04SQc3Y5F88CxE/38zWcqx0D67g7X7VA8Mjl+JpjVQ1A9XSRYkGHGFkpEOedOQuYSvVjktHjFsSKWCil8PXU+dWvLLTFDG7mCfboGCF7WtYz7LkjbZyJ8I2KdoXwuAGe9HTIVMKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029824; c=relaxed/simple;
	bh=dCsM2GcGnu2yIGAAgyi0yWivqPZW1FD9lH6nyKLaDxY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sToKg0oU16J8MN1tLnXA5F3VNAaU7UOxbdK6jbe1Kc9LfXsjl7PYaNfweepAQ7/gSi9o9/Qj+ZfQJ4mT3wB220OxkNsUggh1RNOL0sP70UO7U5OQ4+vj5phEwycsMK6rDbQMJgqYW8UKQgJHJXwqjQhVcfjq0WLdAcqjfe/VzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsizoOWe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsizoOWe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775029823; x=1806565823;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dCsM2GcGnu2yIGAAgyi0yWivqPZW1FD9lH6nyKLaDxY=;
  b=LsizoOWequEqBn2f8RnjNuDKlRMhK1jNKxNPUgieTxneEAk7HD2xiu59
   9/0svJWwSPHzCK9ziMmIkzjpIQ0V/UmSPZD2PCXPu5hHxsaS1w60Yi7rN
   BeEvaERCyrcIJApoqexD2Eq8o9SdNyiD6oq0rRbefEPvIi7+6O7TVq2pD
   YkXC7njQU8IvEIavHy6o1EcdHHo4F0ntMyRXfbPQAyrzSgZ9CYdXsJrT4
   ADDMP5Yl30LBrULc4jmQnTF49MUhCr7iEeLGpiO0tP5x9Dk0ne8tppEdz
   zgH69etzEZhG44sEXcy/iOQjVZzBGckiGNL8EFI3Q3pvhHTZtisep19bI
   g==;
X-CSE-ConnectionGUID: VQCZFRj1SEWXyaK5yBsOkA==
X-CSE-MsgGUID: YVk8LMEkSgqywtdWcBtn8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76073737"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="76073737"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:50:22 -0700
X-CSE-ConnectionGUID: ckf3masOQk2ddxUax5JZBg==
X-CSE-MsgGUID: z8c1q0CZSlC9UK12jDEcPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="228216662"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 00:50:21 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:50:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 00:50:20 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 00:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+ArUEzJEnRYFAyANvDDFeykXCyXexPa0tIzxcamjEwRg3G7ln1+PIsSqBYtjXTC0QfPTg16P2X8YburUrfam/QSvQOjRygZw49MwVjNllA5jyy6PuW2J41/4EHKV3uWheQK0NfPLzs8UUZgAYCPn/xXfrQT7x/nTVpX83eZzEbyB80cbIaUXjSJMjrGs4uMTlE1DQkXzF+U75vsQr6pRHsJ5XaaQbGBAkMiizoapx9cuxh9cY4etz9+AktQ5bIAx3XGE54UrGMUREnv5gQpURWf6Uq3rKw+lMsPUBT01JSBuIrmldbJFPBVEGwc7GnLTY1V8QH6gqqnB49DVrD7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF6Exkw1vbHwRtb9ZHyEkSlzPa9zTFNss5Jh2ogtolM=;
 b=h6hQ4PwAIMmk+UluWDoXZX8wkCQJegLleupM82tHe8yV8vjSdBLOVIb5BJjTbdKAtg2Lx6o04ngRdSpRJ9my/YVq067Un+4EpwRKsYAWC/0RuGtqyQgdUjOOLVCcEDd1FPKYhqWTXyu8/XeydHoHowhJd885mcLQcXmB5LaU1UYSl9Trn2UhJ9kvdwoxCLkDt2u1clhdLxR63fRp4MnCzS1z+3eaJe8SCt+XB0bnob9JvK99lSM/Xu4l46P0eTxSVqMkocorWDwN5i2OejeyR8oG4EODyhu/SOkFykpvdAJJuAyHZxt/rwPYSItUZCIkJJvE1jMqIEGdt+FggXgNrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 07:50:16 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 07:50:15 +0000
Date: Wed, 1 Apr 2026 15:49:58 +0800
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
Subject: Re: [PATCH v7 07/22] coco/tdx-host: Implement firmware upload sysfs
 ABI for TDX module updates
Message-ID: <aczOJt4QuJpQA4c8@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-8-chao.gao@intel.com>
 <01fc8946-eb84-46fa-9458-f345dd3f6033@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01fc8946-eb84-46fa-9458-f345dd3f6033@intel.com>
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL3PR11MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b92ae1-7872-4270-10b1-08de8fc35005
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AviCKx0eHMYHRj3F9ZxtJbWX47/jjI4jvgunzoYEkuNW24lKEM3XQ+bMBEOM129YbbesSmbnMKGwji2uUdY4ZMYuFW+7wTWP8KRFPPxegZW5lp59hr2sQk24AxZHbS7wmxVLoJ6MMn0vzwv/K2IgDeH9NcWnx1IMwXLDlEDJrW8bWSZn+tpEdDS1l5gwImVvaBta7Jidu0dMAPHbhMRAVJwIyJsaBa28odLJIAEPGU5P19rpTPQOnYc2nj89P2cZhfc73M7BKNyaQ0lma4pt0Q8nx/6PapssUkwYYqO9HZ0E31qxajgDC3GC7+bPuWZjcv3pePUrMvKmsqqQDRS3umR0LkPvLmr0TcNRlpixe9v/0TjF3mOD1ZKy25Ni9r9rKk7uC9yR6fp9WbkUnMaAd9xNX0/7TN3NLq6yjWW0jSETBxdzFt202ceqzP2bbHJB2PXqRzgZ7Yk7GihLk+5KpFzlsgoKQdyIIeLp+6Ll/J39dZF5w7VMp++yk79cPLIblzacbtiaJVrktEKdM2kGmY+ch582ML9wn/ZM+h6xa55Iw1fPAU+r6dkgAtbRxKt41PF4PBGP3npaBx3na0ni3Uk0yRlWPz1IRoeKD2dWw46uhsrH3SXHRJdjb8BvOPuei7O0IH9xNOpoJeBcdNUIk+0TfwmkCNJFYIZF77jEObcgzcV0D4bItTkzEcssZeKa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vmWVLIUk0WruovJ25z3V6/KDWteIC8+S1DnUjWhu1FSdCn8dIj5ZaWd0aq7S?=
 =?us-ascii?Q?wspSDoBsiqx9yMhgcK1imMIPFNhAoZlRazubQ/BlnfafKQgcFkupg4Mki1HY?=
 =?us-ascii?Q?CxTecs/hMtvEQl/M3L+lAFMhvsVtPi2PR7l0+GkGirbtFzdxhtS9ZpJlu6P/?=
 =?us-ascii?Q?ko9nNxpcnVaL2iBJNvVI8PmMbxsQsl6QzKwAHMZnd1GP4Cb9tdu638G4aSa8?=
 =?us-ascii?Q?NM4SMbXOYklhma2/Yh0y7ZhXWpk3zck5QR/o8kFOIfau1RtRr71fPpLdaVk0?=
 =?us-ascii?Q?Xp5ntJHD0jd77v33pAdaP1dWKP3Xw426rMmHXK2QqIjViTfNQA3xKUw1quHZ?=
 =?us-ascii?Q?m4Iqa/Sy7dobcVWo3EXfFPc+DSDUzBOlVJJW7o5V9+2PY7s4E7LGMASuCFoZ?=
 =?us-ascii?Q?2m8ZRFGjXw0wbhBSpRoqLwdeh129YzlvCN4un15MXOp5xtS3Q5/uqUm4aKvt?=
 =?us-ascii?Q?9W7xCVmTZzbx8XBumRBRudvzeIt69spbilSCYPaqhFxEgjKYRbESY/hpSnlu?=
 =?us-ascii?Q?tl+XpuRd17t++ERmKLFGqzoH32BvsWxDSv/chGUjkyDmyz2Le3xL/l7qCzKl?=
 =?us-ascii?Q?n/TWL8HdK2Mi9Lwphjx5RxGZx3yyJyOCAkNJ1whGZuN0MCtEe/KdZur6x+93?=
 =?us-ascii?Q?rUeAzzLSq09NO4yTNST1yvinfHuKl9AUqtyH8aIMsbb1ckSaqx5fNAUyhORY?=
 =?us-ascii?Q?6XalMSkoiYoT0sA79G0KyKDeon8+QMg/ypdJxZalzePntnxc3hUU8t4MEDNp?=
 =?us-ascii?Q?SKPaYvIQDiAbYD8EZT3Prc+nbXriK4yqa5l5A3Dsmdguk/e67UZ2TbjJIMkx?=
 =?us-ascii?Q?7zCu0fEWHsawmkNVFVCz039cPq94N8eSZ4MmBXI5Y0Qp6gteRXKUoHQVXyNY?=
 =?us-ascii?Q?thZAVK4jokug+y/jUYx2udqCoMWCOMltd8wRO9MRHi7etGaLA/o5wT1Hn5EN?=
 =?us-ascii?Q?nPNm+Bq9XTRHj7lmiiJb3PPlyvbYlwXbWqrmyo1Xq+FG7n1hZruqKQJ5xYVh?=
 =?us-ascii?Q?Zu9KGyJU1Uw9EDJmmCufLBvLuoowRBnT//BNTEt5VoYiL30FjtWcXKV0357F?=
 =?us-ascii?Q?MAzlCQM76R+vf9d4f197WjPpSlP9GmldXwF1cSFmJqU6ZjYJveuChKl8HCPb?=
 =?us-ascii?Q?rik/TqHO6G2weaisBk/IMGwGm4NRYvtzC6VpYObWxP3+DB1/V513h1F85Wb4?=
 =?us-ascii?Q?cohuycf6tH1VakglZKcCROM0oQnfcJu3BOgGZuCGrjFmQUCpFhDJgg1jic/+?=
 =?us-ascii?Q?+rsY5ofNPid72dLdcB8Xd1sgyAO1mN782xyg/JopyYUxYnUSItckHEuWrNdl?=
 =?us-ascii?Q?QOi2TphMwp7JazQm06ql/7gtrcfC9bQPfMEOBRNzGcuYw0rxsFBKyeCQwOLQ?=
 =?us-ascii?Q?X8e4xYYhoL9YjnM99Q37DQBU91ndccWL5Ybca8q5v1eWvTgUDjfvCzcIFfux?=
 =?us-ascii?Q?gAznQ0doaKInc3shWDg8ZR7l0l6w82hmkTfETafCNQkE7lgqUHCGZ5Qaf7PE?=
 =?us-ascii?Q?mv7p6l9jTRLTx4jTZnZ5AoyympMNZ7M+03uM059PDEHnb8p6lfL/1Bz+ypGc?=
 =?us-ascii?Q?1s3uoAXSLgzb8nK59aQ3cJPf+nDXKLXcpj7JGFZABawEg/tpNMaRo0lYFEni?=
 =?us-ascii?Q?eFpXyZKhaldHHFYnMm3zWUN2Aiwpq2FDBFB62F7B9gNPVB1OooTq9N5YFtFk?=
 =?us-ascii?Q?4HqYmW33RwkMZHTZs9JWTzi0i5ndFExmR7Spg6GqxmRvXchdkxMZx8hLct4C?=
 =?us-ascii?Q?1lVO88Tf2g=3D=3D?=
X-Exchange-RoutingPolicyChecked: LMKeG24wIJpS79gqDVLn7rjSnf/rcFqIU5ljIh/4HXq1/y2pJ4ItK+SKeH2D3guxZrYtOVbAvRwqY2fgVbH9HaTRRKG0eK4cEaNq8anpFrKyM+ak3Lu8Xz/a8jNbQe9+ikU9RVjysq97GeMu+0W6mK/uQBxf39J5KvAanHKniGpyBr9aRWgpuM9sq/s0KbPOfttUzV67asW0RkDpji7TyrN915HZzJFIKRQRWBYfefjFxD4g4+o/VrrmM1DlAM9TW9Ho9AqPXmvLlD/WTijUontWflZDYlJM9qM6eGNIphf426h9i5l4LNiqjrsSra9SmYSrZXcrpPW60RYXREKsoQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b92ae1-7872-4270-10b1-08de8fc35005
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:50:15.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9T8+0DTFnHr+H4UYGrEBDlkd9gMMwuiizFa0bBD1XHAlyBc52VbNmsMlYSashiLM+hp0c6Bnxg0ODequ2oQl7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

On Tue, Mar 31, 2026 at 08:11:22AM -0700, Dave Hansen wrote:
>On 3/31/26 05:41, Chao Gao wrote:
>> +static enum fw_upload_err tdx_fw_poll_complete(struct fw_upload *fwl)
>> +{
>> +	/*
>> +	 * TDX module updates are completed in the previous phase
>> +	 * (tdx_fw_write()). If any error occurred, the previous phase
>> +	 * would return an error code to abort the update process. In
>> +	 * other words, reaching this point means the update succeeded.
>> +	 */
>> +	return FW_UPLOAD_ERR_NONE;
>> +}
>> +
>
>This will be the seventh 'fw_upload_ops' and the third that has this
>pattern of not needing a ->poll_complete() implementation. It seems like
>allowing a NULL ->poll_complete or having a common stub for this pattern
>would be worthwhile.

Thanks for this suggestion. allowing a NULL ->poll_complete looks good.

I will post a separate series for this. the core change would be:

From b0d02c337db9df040b702f57a28e960da04bd9e3 Mon Sep 17 00:00:00 2001
From: Chao Gao <chao.gao@intel.com>
Date: Tue, 31 Mar 2026 22:17:36 -0700
Subject: [PATCH] firmware_loader: Make fw_upload_ops::poll_complete() optional

mpfs-auto-update.c and thp7312.c implement poll_complete() as a trivial
stub that simply returns FW_UPLOAD_ERR_NONE, because their write() is
synchronous and the upload completes before fw_upload_ops::write() returns.

Make poll_complete() optional so that drivers with synchronous write()
don't need to duplicate this trivial stub. When the callback is not
provided, assume the upload has completed and simply return
FW_UPLOAD_ERR_NONE.

An alternative would be defining and exporting a common stub, but
exporting a stub seems unnecessary and differs from the optional
fw_upload_ops::cleanup() handling.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Link: https://lore.kernel.org/kvm/01fc8946-eb84-46fa-9458-f345dd3f6033@intel.com/
---
 drivers/base/firmware_loader/sysfs_upload.c | 12 +++++++++---
 include/linux/firmware.h                    |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index f59a7856934c..06788a6d7227 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -158,6 +158,13 @@ static void fw_upload_prog_complete(struct fw_upload_priv *fwlp)
	mutex_unlock(&fwlp->lock);
 }
 
+static enum fw_upload_err fw_upload_poll_complete(struct fw_upload_priv *fwlp)
+{
+	if (!fwlp->ops->poll_complete)
+		return FW_UPLOAD_ERR_NONE;
+	return fwlp->ops->poll_complete(fwlp->fw_upload);
+}
+
 static void fw_upload_main(struct work_struct *work)
 {
	struct fw_upload_priv *fwlp;
@@ -197,7 +204,7 @@ static void fw_upload_main(struct work_struct *work)
	}
 
	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PROGRAMMING);
-	ret = fwlp->ops->poll_complete(fwl);
+	ret = fw_upload_poll_complete(fwlp);
	if (ret != FW_UPLOAD_ERR_NONE)
		fw_upload_set_error(fwlp, ret);
 
@@ -306,8 +313,7 @@ firmware_upload_register(struct module *module, struct device *parent,
	if (!name || name[0] == '\0')
		return ERR_PTR(-EINVAL);
 
-	if (!ops || !ops->cancel || !ops->prepare ||
-	    !ops->write || !ops->poll_complete) {
+	if (!ops || !ops->cancel || !ops->prepare || !ops->write) {
		dev_err(parent, "Attempt to register without all required ops\n");
		return ERR_PTR(-EINVAL);
	}
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index aae1b85ffc10..c320e8b3e708 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -57,7 +57,7 @@ struct fw_upload {
  *			  size written or a negative error code. The write()
  *			  op will be called repeatedly until all data is
  *			  written.
- * @poll_complete:	  Required: Check for the completion of the
+ * @poll_complete:	  Optional: Check for the completion of the
  *			  HW authentication/programming process.
  * @cancel:		  Required: Request cancellation of update. This op
  *			  is called from the context of a different kernel
-- 
2.47.3


>
>I also don't think you need to be that verbose. This would be fine:
>
>	/*
>	 * The upload completed during tdx_fw_write().
>	 * Never poll for completion.
>	 */

Sure. thanks.
>
>
>
