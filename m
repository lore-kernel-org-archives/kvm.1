Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011061.outbound.protection.outlook.com [40.93.194.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19903233D9E;
	Tue, 28 Apr 2026 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416938; cv=fail; b=QV2HegWTQ3oFpwrWP1d5B3ga0xBBYG1dzpShPXBSMjeVTa9Q9iIZ3UJCSTghJ26qPfDcr0D0zpBkjLGgn60zB18hJOzrN4WhOrfWibydby9Vf3cVvuJ4LeCANzoSfWoGZCjyL36od34tIdQrlx8dtuPWfVZn08R8l5UcY0yNuhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416938; c=relaxed/simple;
	bh=JL+cuR96VTlh/En4kEpHkV7ayNJksayIU5MZqgD1sTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+hv3KOqBS7Z8ZkR4W+aosoARAh0Hs1GYUyoujP0FVcD2tUZxgV5RXTeEgXRZtqTp2cX+J6a3p/pyrdVqvT4kv/gw6GUS0DIARA4u4m4qmI1qWo12O3AN2yLKQKkxVOeNIogWcAuJy99NHSiKTYv90wIaSa6UzdIbmCHcgwld+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TrImgE2z; arc=fail smtp.client-ip=40.93.194.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TrImgE2z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVeMxeP5rfeChtR81gJTXv7YxbnEsD3GkGapCcCB5S34RCb6Pt+ekpiWqYswddryhQNTNoSZVQ6SaagH/7V5odaei/fgTf8GtGqn1MFaHxrPMNX5qLfjNjjXWotBYv9yviOCmlo4mAVddhAvysT6d4QHaWi+pzPS6d+sYbbBJ3ke1CBGqvmlvbi4bAE/51lTyeFGv67UFqw0DQpwGj415chGjngjkOIhQ6HWv677yf4ja9Pmn5rb4GljXGmGSXiNwyWe+U3muYTE239hFBo54ba6JEL/gY8GGtWuJwLR3IL9ZOra/s345hP9MmGHMdqUdE6LYWVpAPNSpS2x9O7aFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOeSAQvuLQNH24hxRSk4Ry848l7vGq+KoKUaRcPYBiU=;
 b=RsJodmmYtxD1fop0720kbaOTNUCvjMCd/V2Lopi6l2croKNsGgQdHRLefqQv9l8zGU1Wlgf/lT1AA0LLflhVrYl26l5LUqwot4h2ZWq96yf/gI8f0W8tzQ8ovTmGAXJ9we6DmIws5QHsPJ/KTm87EUmx/QtbB6aUlA97yH6qkCg8aTx3kfIWFS27A9qobVIynPt+W7Vo8a47sTBMKu7NuP6BUeZZp80rVEhuv11cFQwnyEGVFu1Z61EEG6Bk+gM6qkosesYZQMRpQgicJ7hm1POFe84DnvFLvFeb9crdxomAC5vsWmX+BwjZ0WiaRALMT39lZsDXBumiPeX1HsVQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOeSAQvuLQNH24hxRSk4Ry848l7vGq+KoKUaRcPYBiU=;
 b=TrImgE2zSQOffvyLiVIi8K/lMyLq+vLKfz9emKRFTijEtIunFT0+E8QHKHN8BA73I8rRK+z8vGTfXJsRP5aBwBWHOLvLv2ncxkbOSLn21fYyUqOgBxFnsGebwQiPym4Ts3OAmY/2rAXNnpblecsR/9NGfbFgc+Uk08JnY4IAaFFKBHP10z6evr9RYTwnbNxsjZtnFig1j6KOL8ctWQ2MtH2rwtG1J00+Qa9DdlTR10iml8TmtIRM4LSgi2CNF3cjNyiWYcY063VpcVwj+kHK0SGkGq7J9a1S5wVZVxJQIIDqPmRMj2b7qP5BBSgoSsl7945qy1xjJ5luHZPJgOXV+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 22:55:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 22:55:29 +0000
Date: Tue, 28 Apr 2026 19:55:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Matt Evans <mattev@meta.com>,
	Ted Logan <tedlogan@fb.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
Message-ID: <20260428225528.GA3225388@nvidia.com>
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com>
 <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com>
 <afEEN_4ufBcQld0q@google.com>
 <afEQDT_nv0kdlaBU@google.com>
 <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
 <afEusUxXDpFtZvV0@google.com>
 <CALzav=e08+Kh60daAM=A7rAwRU-SFs8m7k2JqSb6v+=T9RZGSQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=e08+Kh60daAM=A7rAwRU-SFs8m7k2JqSb6v+=T9RZGSQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:36e::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 70983906-0c4c-45b3-84a2-08dea5793ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	shM6uEoZ0ZQdI1SgNFfJIoIvacBUaM+111Fk+N+jzg/yZ4UPqpYS2HYO15sZGw8yvDvse55+snnxI0jfZ//AN2bnA6TZqHWHZ85XUGSwVI3uwpxeyzRpYQ3t52bCH3TDJe/nJxytClxX3h6tuSdzZPezINcV4IZLyzSK0nmgWU0WpNWl2xwvNZMcSKwfeYtqj0bIW6XaFvNI3L3MQgsOKFP6WD0EyvINvmM4Sz0GOqyb9awssFe211uEX0jnvj9lbp1Zrp2hR222FWku/JiaCpU3SWlA2OIXpcAFnX9t1Tw+zd7L+S+aTb6ihgMG4g+xmx71Fu4Mx8IZl9XwuacB2n+DAjO5JnKj/E6G7kerDZixrg3BPH3m+x8uksns3z66245QMCcb8XX2NKAKUdsFQafPxYt0XFzU4ohfmKVJPPPE51qcZEHElR9X2RRMuWfLSiaTJld8V1+t+oYhVX/QvzyJ4GDk+DSfm4wHHMJWVQjLooYf8oGDlY15PBdbqE31qF2nWEKZopuD2BN5d37Of3hM0rBcOR9aL3CpE/96jBw+yu7uKq3SiGGlE028Hy1BEG4n+WmR49hmisZlX2JUzzQkhL5CwxjGJd62UdDgFSR290/e/tuAdFlg50rcNXr/4FmOpotCx3Pd74onFU3H2io8XAo4t9sONrxh6WTZPT4+UeLjZ+oefaaN9SmedjF8eal83ncZDSD9XXtg+c2veEbLV6rAJH8HygYV/c0KLRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7tQ/ZbItpmild4wmjGclp1qtNXLOWXGiSMzGBu/yGwtIQKQN+Gh07SILo46z?=
 =?us-ascii?Q?3m66VbMB2c55k7JybPOFL6uo1KJ85wlqGLdEqOR/r87vzCghSnfgtWPbk+er?=
 =?us-ascii?Q?p/cKeyS/rOSVGcbRnyyQ8DMjKWFbsEzl4XE25/yyhThB5/Sho7Ir8pMKTYiB?=
 =?us-ascii?Q?AkZ8g5ca69y5+bfc67VK8aExQIydbkXObiS6Sv2WdgCw50PNo+JWiO+fWQoj?=
 =?us-ascii?Q?cxweY9VBT9ynK2ANYbLBG58kkJGY0Y5MPd9pfET7XDtd48OV/xLBUz7X2TIO?=
 =?us-ascii?Q?ygZRrX3JnoFLYQuRpLpiAngr57X/aRkRY0Xss79DQKzRQkH1VxOwVARElJ8g?=
 =?us-ascii?Q?crHTAuId1pwfIH32yuiGrZ8EGRsJ75iSN1XD8jU6lqUBONFdJG9DikgW47Cy?=
 =?us-ascii?Q?33OXtg/2+O04VF86/cQzXNZSfjTYeY+CUhYnNbpvwtCe0r3xwxxPEae8sGNZ?=
 =?us-ascii?Q?s8e8oOET0JQTG2PduCytvniGPpX17y0Ls7vDM8zCxfvAwB5yz9WMgbWOlw9U?=
 =?us-ascii?Q?7xUeTJ0cAM8umeD4SsLTi2Rdurdv3kq8dA1cIXs6PWdn2w+uZzbAQw0kKR2A?=
 =?us-ascii?Q?6euNcwd03dkITU9LfwV/En75VKl8eeI72KdurFQ/zsiVCaInDLgHluKL6F4w?=
 =?us-ascii?Q?7wHa/ehX8R+BKwbqGhkHe33/pXzYI9Iq+TJQiBVmo7kHGO03Ct0OZQkBx391?=
 =?us-ascii?Q?FrDBMIxqw8NeoBQjp1ghNhN2ydBUoh+aq4kDMmGB4Qkqn/kjwd1v9uj8UR67?=
 =?us-ascii?Q?fT2aXybuKkh2r0EPhZqiOoJ4Atz+n5m6Yky28/wirdFQpRT8hxG9gSo1NQvj?=
 =?us-ascii?Q?hRJP9ly1rEEKOxYoJJmFVLW2KpH2Cw1Nf00rRD6PSbW5WuLTvSIfJq6zfCUF?=
 =?us-ascii?Q?TnCPtJBSwq/dkhHg6NaJaBp/TS8xrsWIITdgcEVtKqc/qGGXlvMmm2onBqlj?=
 =?us-ascii?Q?dr0ztAZFx9sAMd+uOSRadXA0o8aG5vAeUlgO2/wk/n8bOybcPjPnlBnzi8bY?=
 =?us-ascii?Q?KLLKYmfPgyjnsGp3DHYAjIJBgcaeEk0ah6Vw31ifyDaSURoWoqB8AOmgqVWz?=
 =?us-ascii?Q?yQXkidusVILxt9Vv3mwkHYkgaQHAT1Woluy+X8NPU+1PKUQ1fflcNtVbQAQm?=
 =?us-ascii?Q?rk9AjLtcvFdlzXi+PHu7lp806LBh5InHVPt7dPMr9BADx50pcM1w1Z5hIr1z?=
 =?us-ascii?Q?YNYpVTGF/rRZTTm9nBqYbwOEy2qNPVU30/1wtzCS+Fy4u+EST3ISs0gfR4i1?=
 =?us-ascii?Q?6U5JZt7N6uai8FPTsgZ7NnVclxDi4bGKlgwAHWQ6K9gxOag5Wxvp+vX16gEd?=
 =?us-ascii?Q?2DWcMtitc8Gv9/+ecYLTeDfxmTXb2PCZQQeUAjrhAgKTHgUaxgjyVu9S0du6?=
 =?us-ascii?Q?qTrlOMuN8z7osVuDxAPmXEHdIJk7+PdICOx4EgyuRQiWJ1qEa/jsT8mhXmi6?=
 =?us-ascii?Q?TXomDIpDjINtHyCBjxmctz0EIJ9mSI2Vn4tTH0feKKOOAaupiX8JpE+PIXDE?=
 =?us-ascii?Q?7roY6uJ3qE9GPA9lcRbJvpxI3YoS72Z4Fftp61ojJs7jGtpC8G7pCEqA/jOO?=
 =?us-ascii?Q?TMSoiXsIMYvA7R9+lq8Kg1zHXL+YP5FMiRkiNMYq/l6gO06ALmOsjs+U7ltO?=
 =?us-ascii?Q?s2AdpmkLb0A2TAMbHgYJWhlUKjMUYgm5aRz5sN5Xn17uJbRexSuNQ2qr7FAd?=
 =?us-ascii?Q?XOcrgFhveCemGLQBGcJvmFOgfpJzwbM7sWXQ8YRPFq1MNrjP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70983906-0c4c-45b3-84a2-08dea5793ec1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 22:55:29.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmq7uhTMo0pG8BzR+thK7/AMDACVoqTRObiM2qPlTfQln8b6MOfvbduQnLnJL0xB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345

On Tue, Apr 28, 2026 at 03:53:01PM -0700, David Matlack wrote:
> > > If it is then we don't even need the __LP64__ stuff I posted.
> > >
> > > But when I look at the top-level Makefile and imagine running make
> > > without setting ARCH on the command line on a 32-bit x86 host, ARCH
> > > will be set to SUBARCH, which will be x86.
> >
> > Yep.  So the big question is, why doesn't anyone complain about KVM selftests not
> > building on 32-bit?  Because they most definitely don't build.
> 
> I guess no one's building on 32-bit hosts anymore? :)

Well, if that's the case and kvm is broken too, then just ignore it
and turn on vfio for x86 like kvm does?

No sense in just fixing it for VFIO..

<sigh wishes to have a better build system for userspace selftests>

Jason
