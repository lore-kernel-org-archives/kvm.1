Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04C3749ED;
	Tue, 30 Jun 2026 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787028; cv=fail; b=lFseJ5CJa8b5sEwwp6XmOaCfKbhNMzFYvURrkqM/nUKbM4wD/MKma5YpNigBT8+sCOMpx4rz4hse5QlMoApJjs3U2OXzsPfH5GFFx39U0lSImmn67Rd+v66nDCVILERVPfxqE1YdRdaf203JowzQ8yQxeTCBeaRyFhuhbJ47gvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787028; c=relaxed/simple;
	bh=p/1kzEcQJ0o7be7DNp25yVaLFPksQQvEG9oG0pdATUo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/VUPLBAW47dQsfevO6/whcaqh1KSZtBIt6j8LXp4W1nI7y07tJ89KDLz5MN7GmQV8lFK+lMKjPq2sSHCX8y6m60y7OWf2UCi3cDPkCAcrX+zviFh3J1xH5Ofr3QJUswgSGkhBaxABFZ1ZcR1n9JtrwuiKiyyPspE6rlqoLbOV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASPN3a+z; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASPN3a+z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782787027; x=1814323027;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=p/1kzEcQJ0o7be7DNp25yVaLFPksQQvEG9oG0pdATUo=;
  b=ASPN3a+zgHfOVah7cTaeA7JvZDfFckCDN+BelQv4+6xjgdjn9mP2XJSh
   tfEZ8JnmUh3o4HCtWC1q/OD+Y34XkIQqi/9y2AnRorfONrWcnAMf3S2vB
   IcldyIuKaVqjn6KhWgyk7ZUIzl+WGqFBVzuN+FHj6+zopJKuwBbnvaZur
   x+AbeL67ToOf2WSzyF/p4Hr+3JmqoAgbHNPT3aOwn8VK9wLeXhZzpvhEc
   9nDhCvNzrIR4fjs5+SgpjcYH9R32NSIRh3ZdbNEmWVXZVWP+j6pcfG1zS
   IRg/XE63IYlVzSYtsogvhMVR/qk1tfyx3X4d0AHyARtKsfjnxYVW0Pd9j
   A==;
X-CSE-ConnectionGUID: k5JPKPUlSU62Ged0vtH60g==
X-CSE-MsgGUID: C++Ig37uQve7QZ4CIbFq9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94642915"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94642915"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:37:06 -0700
X-CSE-ConnectionGUID: WH//89cSRC+Et7KFz7JlZg==
X-CSE-MsgGUID: d0Wt7zqOSwiDNthWzLLpBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="282195799"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:37:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:37:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 19:37:05 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.11) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:37:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxxoG3qvhRK4vKdnHNskfVKp9rVEowVwVCRz5js+qsNCCbRuwc0diJaXm4O3fmCnqatRIJtGz2PZ/Jq5SB9BCWm8Ambzx8noY7U3WbbKnNoUpn3Lc8bDycfyjCX6yDtwpVNRb5kqXOxeImvcSgHfWMsCzTEkQ2J3OXe8sjD1k5uE0Xwn4TJnXPsD8JY6CGK/W9fKodweBTAR3YnPH1idjV0jSMJU+yDGqh1nNdGEX2x23TtOxmluVlbdRkkFsvJMzaOHcHmt9IEmp0q/v1Qlx3Q3Af6gQhtjJRnxKBbbly9WK+qMelqz6nKsEap4aFjnHpXEOqdCxmlYsarAXwVSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUeGlDe7SMMWWeBV9DT37jiWSCuQ5mvrjw2M8N8vnC0=;
 b=TWrJoUNTrHwwKKSznbD1sIj11wqAaeMIr5Z0+7IRdg0tmzzLeJk0Eu/XcLHVZrOH7+CG2MQmFGy1vF/eoLTkob11cNxR/rIZD34M08E4ghkjytNxVnFmyfnbrmN96elNpzbkZfkDr/jL+nTboWYoGXDaHywI9j8O1pT56N6UXvoknuQKDRLvrPFYcmt9rKriNfTFNa0mOS9faioc0YajLSYkz1qbIdtFHLwFpSDBvnlm64Rg1PNW7ALgDElhEtjSAvwDhXp82WicRGWdcLkw7OTsaOGyAT36YMovx4GANI3hJa5Vv0K/PVX5JVehikwKReraOM5jbjjSlLGNP68F2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by PH8PR11MB6756.namprd11.prod.outlook.com (2603:10b6:510:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:37:01 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:37:01 +0000
Date: Tue, 30 Jun 2026 10:36:57 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang,
 Kai" <kai.huang@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>, "sagis@google.com"
	<sagis@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "Annapurve, Vishal" <vannapurve@google.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [RFC PATCH v5 30/45] x86/virt/tdx: Add API to demote a 2MB
 mapping to 512 4KB mappings
Message-ID: <akMryYJGxIk+FnbO@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260129011517.3545883-1-seanjc@google.com>
 <20260129011517.3545883-31-seanjc@google.com>
 <aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com>
 <9c22a8bc7f326f81effdff27fd72c3c5339e5053.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c22a8bc7f326f81effdff27fd72c3c5339e5053.camel@intel.com>
X-ClientProxiedBy: KL1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:820:c::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|PH8PR11MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dfc977-869f-4a6e-d946-08ded65076bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|22082099003|4143699003|11063799006|18002099003|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: qW1tYOxEJb64GkYklBMmTrrcB+r53TFK3iYlMhRbNdDytdsRHhr9OAShZ8z11GSa2DLWigtaQkzj9ANkQlqEk3SUI1coQA/BRHhflvk1aMXCxF1olOKFWlcNOycMMwrJYEzrj9zCWJZImx9Saz0ePfyhmzMAjpIVjyGaXpfs07TZYKmWpNQipudIcVuiBZIprX+22AJhQ0Om1CqGAQk/B+buBdS09ekOv20JR28tVc/KbjFPE6HTog1FsYarneihxiEXUXdrtqB5u9t8jRql73UEWSJwJ2YVq+tQj+1RsyyfpQe26wRIqfquhWmfD51M7xYPQq7bVmyOhECAEanNsFpiTz7sjTcfxPZ3O74p+u0GhFbyemtfQVHWw5Yx1qI+B/kj93ETPcwGgvLpA9yRq7CHwXMhxaG9lf9+V/eY7MmjoebWI3LgZ/nJV60BwYvKCdSu5lt7aG+ApFT1QTsKB7wtJp3t9Ul96RPfnCVzUIgSAlIYkl/kxk1t+3ZkY0BdYwqacUMIPz2TrShim1YrtmMZ0XBmWsmdM6FcFwKOlRze1Wy2KB3/VI0+8VhsbM6KWuajaeUS5VPI2v3wPRBLs6ejBEyP0gTWNl7OEZIqbaV+cFJT0Bo5Z98bOyMgWIZicnHnV0J4fNgOlkwKG1Pmz3LuT0S+ylAyUFN7cQa02Jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(22082099003)(4143699003)(11063799006)(18002099003)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YlTzWGsbRwgQkeFsuTWGMbumoDwX67rZIzyJkOyInj6WoGeO0Hd+HTaxDH?=
 =?iso-8859-1?Q?VM20OOiUgv91KZHpnTD9HGi0KF1CuE+joyxsc0T09YEfnXYgz9viGf89o4?=
 =?iso-8859-1?Q?NmbTX+VK12INvdiemyMOnjQC2zpVUWB36mWt+AN0KvZRW1Nvgbq4aS4m1m?=
 =?iso-8859-1?Q?RoVk0XHR5Xx6bO2tkZJ6szuj2E/Di1Zuik3Bk7ngOBd2n42oL+AQkhpVE1?=
 =?iso-8859-1?Q?bUm7QnNkBUwgoI+OTz7qeUOHgia7ClyrF6VVPkTF3pTvXxlqJB1u0POApo?=
 =?iso-8859-1?Q?Hwzxa9P/Hy0nEKXgUx7YxkRKJjHazw6vvlopE55llFso+ugsPJ7uosR6Fp?=
 =?iso-8859-1?Q?zyGMNXXNNZB1VhXtQC4kKo1vqz9FtkE6VIh+kBl+cmSrIpgi+HY72SCSis?=
 =?iso-8859-1?Q?NJeBMZ3Dm7lLb4/ta6/ecuuL4qAsEHWKOe8/SJ9EbBcFJmFmYowUxcaJaU?=
 =?iso-8859-1?Q?Ebtkr1YFt9gYX0lYmCwl7/+/GiMzkc8BfQ7TQiBB6bGeD1nvHTvzSPi9C9?=
 =?iso-8859-1?Q?xv9+4dBM6/UpgiLY1b41Yt59hbGmkYT/3l27PqvtH59V2Bkdzsm6gBTxl/?=
 =?iso-8859-1?Q?HbBjxvG6T8ypt8deoahVD8JmWzd70ELKxnZ4qQnaHXX/sEcHnDN3T2DtV1?=
 =?iso-8859-1?Q?UNfy1/sBZvD4vxZnObghNwxWZTR+cPsSE3s8MHYOD2npd9r2JsE+et+r8y?=
 =?iso-8859-1?Q?p/DVbcX3Ip+lw6UD8XKdP90IGuul7g49jd7aOf/R+Vc47GjmsjgQV28K5F?=
 =?iso-8859-1?Q?vz/3VuWmekql9v96379Vncx6He+vMDBcrCnS2JNkHvMu7FJjVu81FaeIdn?=
 =?iso-8859-1?Q?33Z+D4D1LgTqTUoL++dsUCAYlQE7H0Lu7l9aJdIoLDe6eE/mxLOd67accH?=
 =?iso-8859-1?Q?Ta4hiWBD9LFyiQ2VagsjwXkkiBpSsShLW6puraRBm1dO+7/7f5zLGGwIwI?=
 =?iso-8859-1?Q?W6FLSmXk+3RW/pUd4E4qcuwcRxziMIrsWZcUEqMT8vuavvNwtF43La0KmA?=
 =?iso-8859-1?Q?YxIvL0S3kJLHixtSBH3RJyhO6EgDKyfK3GY9PVgw2lIpqYsN5B5TuVgnte?=
 =?iso-8859-1?Q?JCHJwxoMAR3EUyHJjjTY6wlp7YU5aRQ5gG9DZBzm58V90yIu47sCt93Oec?=
 =?iso-8859-1?Q?eeKwVyVcw1Q4sIYK8PUxkO9tLkFLSyTUv8ArVGFZSdtrrlyh0uibeB5nlT?=
 =?iso-8859-1?Q?YXmofrhRDNBa3oILiV/NsWtmL8lTRkwSaOVknHq7KIPKlFXmSmsi64VBh4?=
 =?iso-8859-1?Q?5sVg5IO8lU9ufdJXXsqTA689M1kG8SYTXQcRLcvPMA3/IhPysEUVK2OaVE?=
 =?iso-8859-1?Q?6Z973PmjIwiITJqhzu6JsKRHeqMDAU1Hu5XvCh/96uRJLtKQg/F7X4fAxK?=
 =?iso-8859-1?Q?jPP1fYnmdhgdwz7SiRr7es4+oHXj2zAbQUR80u/2yODhxb+AYroAWSA5Mf?=
 =?iso-8859-1?Q?CSm7go1NvU4C9EmeYwr2gqPuQCcnaasmjvHOuHhMRrImTVXL+Qljb2+CSK?=
 =?iso-8859-1?Q?Mu2g2B95PQ/nd+gO/VUdzsD27nBaQPKYQ0eOckguy5Gbf+Vbv5PiUVjRvw?=
 =?iso-8859-1?Q?U453b65g4NsuOAlRiHVOvxyJS/hQouyxMIxD/U4yhjNsLCn1EgXSBsoqDt?=
 =?iso-8859-1?Q?K4OKIa2CqXlbmMvQqkfJNrMLmlwrNr6XG4AMeQX+jp8l6qFKhrha/dIU4r?=
 =?iso-8859-1?Q?logpQPXci6A9RobnTjb1B2M/yn8/94oNjBl73zStoh9U5YfsE2HV+O4kVo?=
 =?iso-8859-1?Q?GvIGUc+vyxqMKwNPvJY3pS43C/ZZndeO1QzWHfNBgrT2P84SKZHhV1IyxE?=
 =?iso-8859-1?Q?3KCDYv6xqg=3D=3D?=
X-Exchange-RoutingPolicyChecked: BQk8mDo8XhuR7c0/1+e0KyyfIVj6yvrjAdRzCzCtHT64Jr9QpI53ydgjd8Nb8vQrPZ5JAgf+774dW8RDiJC2ohJKy9T5xJV79hNP9J+VuIS4qrQiuGSNIy2KoCLysAbR2awFtCreVnxkJiYW2O8rgRhMQVDVX5xUDtilsP4AfiHSnym+K2GwtwHPSB4DZCWczJs1iFZ7tEHs7GqiiBqel15k4l5hOGeb3wiK5zLerQza6HHUwIriLkHsw6W2Js6eKPLONC0CRfas1frQPbumtAoLoTlDK5/HyDbUPHpCimeNQLNpJZWhaHV5hxc2DVHjTjAZZJ2gmDWhyTedQO6EZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dfc977-869f-4a6e-d946-08ded65076bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:37:01.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBXgeB7SdTUK5F4x3Qw3ZRgMPwu7fL+YdSHKSqakKVTRy/As3MiGleRqwt2uQKwq+in7EZdhhBcTYDvhkD3AqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6756
X-OriginatorOrg: intel.com

On Tue, Jun 30, 2026 at 05:07:13AM +0800, Edgecombe, Rick P wrote:
> On Thu, 2026-06-11 at 16:44 +0800, Yan Zhao wrote:
> 
> Nice find.
> 
> > Since this contention should occur rarely (e.g., when there's a second TD
> > invoking PAMT.ADD concurrently while the first TD is invoking DEMOTE, and the
> > DPAMT page pair to add for DEMOTE must reside in the 2MB target range as
> > PAMT.ADD),  a possible optimization is to avoid holding the global pamt_lock in
> > the first invocation of tdh_mem_page_demote() (e.g., by indicating try or fast
> > mode); only acquire the global pamt_lock if the first try returns busy, ensuring
> > the second invocation must succeed.
> 
> Yes, let's not do it for the initial implementation. 
Ok. I can put the optimization in the TODO list.

> > 
> > [1] https://lore.kernel.org/kvm/aNX6V6OSIwly1hu4@yzhao56-desk.sh.intel.com
> > [2] The contention is verified with an internal POC.
> >     Error logs:
> >     a.1) DEMOTE adds PAMT pages pfn1=0x19c0a0, pfn2=0x1b572f for guest pfn=0x519800
> >       2) __tdx_pamt_get() adds PAMT pages for pfn=0x19c0a1.
> >       3) DEMOTE returns error 0x800002000000000c.
> >     b.1) DEMOTE adds PAMT pages pfn1=0x1b090c, pfn2=0x119b4f for guest pfn=0x511a00
> >       2) __tdx_pamt_get() adds PAMT pages for pfn=0x1b090d
> >       3) PAMT.ADD returns error 0x8000020000000001.
> > 
> > [3] New implementation:
> > u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, u64 pfn,
> >                         struct page *new_sp, struct tdx_pamt_cache *pamt_cache,  
> >                         u64 *ext_err1, u64 *ext_err2)                            
> > {                                                                                
> >         bool dpamt = tdx_supports_dynamic_pamt(&tdx_sysinfo) && level == PG_LEVEL_2M;
> >         struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];                       
> >         struct tdx_module_args args = {                                          
> >                 .rcx = gpa | pg_level_to_tdx_sept_level(level),                  
> >                 .rdx = tdx_tdr_pa(td),                                           
> >                 .r8 = page_to_phys(new_sp),                                      
> >         };                                                                       
> >         atomic_t *pamt_refcount;                                                 
> >         u64 ret;                                                                 
> >                                                                                  
> >         if (!tdx_supports_demote_nointerrupt(&tdx_sysinfo))                      
> >                 return TDX_SW_ERROR;                                             
> >                                                                                  
> >         /* Flush the new S-EPT page to be added */                               
> >         tdx_clflush_page(new_sp);                                                
> >                                                                                  
> >         if (dpamt) {                             
> > 
> 
> Can we just not do huge pages if we don't have DPAMT? Actually, weren't we
Yes, we can.
I wasn't aware we're going to disallow huge page if we don't have DPAMT.
I thought we could have huge page with and without DPAMT.

> already going to do it like that?
Is this to avoid the "if (dpamt)" check here?
We may still need to check "level == PG_LEVEL_2M" here, since DPAMT related
code is not necessary if the demotion is from 1GB to 2MB.
(This tdh_mem_page_demote() implementation could support 1GB --> 2MB demotion
theoretically).
Or maybe for now just warn and return TDX_SW_ERROR if level != PG_LEVEL_2M ?

> >                                 
> >                 if (alloc_pamt_array(pamt_pages, pamt_cache))                    
> >                         return TDX_SW_ERROR;                                     
> >                                                                                  
> >                 args.r12 = page_to_phys(pamt_pages[0]);                          
> >                 args.r13 = page_to_phys(pamt_pages[1]);                          
> >                                                                                  
> >                 /*                                                               
> >                  * Before demotion, the 2MB guest memory range is not managed    
> >                  * by DPAMT, so its pamt_refcount should be 0.                   
> >                  * Set it to 512 after demotion succeeds, since removing of each 
> >                  * 4KB mapping will reduce the refcount by 1.                    
> >                  */                                                              
> >                 pamt_refcount = tdx_find_pamt_refcount(pfn);                     
> 
> It feels kind of hacky. The refcount stuff is already a bit hard to follow.
After demotion, there would be 512 4KB mappings for this 2MB range.
Then, in later tdx_sept_remove_leaf_spte(), tdx_pamt_put() would be invoked
for 512 times. That's why we need to set the refcount to 512 after a successful
demotion here.

> 
> >                                                                                  
> >                 spin_lock(&pamt_lock);                                           
> >         } 
> > 	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
> > 
> >         if (dpamt) {
> >                 if (!ret)
> >                         WARN_ON_ONCE(atomic_cmpxchg_release(pamt_refcount, 0, PTRS_PER_PMD));
> > 
> >                 spin_unlock(&pamt_lock);
> > 
> >                 if (ret)
> >                         free_pamt_array(pamt_pages);
> >         }
> > 
> >         *ext_err1 = args.rcx;
> >         *ext_err2 = args.rdx;
> > 
> >         return ret;
> > }
> 
