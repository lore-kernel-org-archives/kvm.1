Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792725904;
	b=kKKChomHO5SB5lOTCcymUBCxKlXq4Hd9w0X9spAy+tfH0iArJGBqNYm0jC5Be+BRtnQo
	 AzcZgB3mo5/HobKWzNeS2WUTZexYS5e2jkM//ciG0Ehg47CaZCpLUega21A7ejlZz6VZU
	 JB5q69odL8/DtdZzlUf93gMPr0+t+WyvIeJKXnYrQbcl3Mjfuib2rkq33nYXEQ9j8Ki4t
	 1SQODhIYSYvYwvlwynPGE5Kt7O+mx1hzp45lVgKPJUcK1a8nyWoLBgELYAbuTBqXk9ShL
	 t7MOPvRuxnbOgH67CQdIqC+kF5ooo0IKbciDDw0xFv+l7CfCx67bHVL1hUBog8hkLrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792725904;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1zc+HPUuJE+zo0t8EBG8rma0duDRiDZwNjDhkld9W4Y=;
	b=YrAoQXmUBZST8mQnaH8CSwoxydYbPbBkUr0CMECm4xqF1QgX5OkzhF30TKshbb7Vvb4I
	 ZSQVk4plV9G0T5WBadezWd/Dy5fq8zhRdqSBvWOPSBnToT1s8nLcFDzbuZNBF8XR7k1pG
	 PsYwexkhrVD4vhYvQUeQyURHOUUtLCmiz7q0Jr1b8dJqteEIv0rr4F2Ui8s3bxlLoS1zJ
	 bNXYmGWPKWf8l5k3xBWNHf8h8jeKJapjCORH/pUMOg+dB075BcC8brNi5bEmaZn4/jrJa
	 2ODYvqJFZSkGellOFdcA1XmLRmIopVXLgLCqWPhqiztEYPme4PVhwPTQxkPmSwF47UQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hoqCsnBa;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380B606A319;
	Fri, 23 Oct 2026 03:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C380B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hoqCsnBa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792725903; x=1824261903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tgpFcS2NO+ES86PZKSSHfu2ETvsdjiID9vIx1YAA/LM=;
  b=hoqCsnBaphX+fVNL77ucQGGGP3Ue3+eeWGXs8BOrZJMp5jWckz6yyI3U
   pzVKAfHSDr4onlgPsiEZGY91zW78swefcvJyXbQnlayNzzBllKaLQ7ZVe
   PQkdjrEMS1oVCIlb5uhNgLMnSDJTtmaqi6X4bCmMAZ6T2LmtcZcT1XMhf
   SDckwMWDxYXJN03hb5NbfZGb8Co6Vw8WVy3B14L5YsXT3Uacq0482jjmR
   OzwS0ruaFxgwCouBkwYrO94VO2Qpfyk/RH8+XyPyMK924tXJTavQhfeQx
   KdGzOUzPjh8JcCyotavf4dzIqK62ke1Vm4LUri0VZZr0UfCaVNw6U3afG
   w==;
X-CSE-ConnectionGUID: R7zUdwOLSn2i+vqKrplt+Q==
X-CSE-MsgGUID: 2e35KZjmQ3GIken9XOZ52w==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1504036"
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="1504036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:25:02 -0700
X-CSE-ConnectionGUID: iF5fPUtWRKiLuQhtDh5fVA==
X-CSE-MsgGUID: gC7kck1gRqKO07k8wX+LNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,173,1787036400"; 
   d="scan'208";a="3622472"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 20:25:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:24:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 20:24:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 20:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Km8Lc62sKLjz77JZMWARAty9CcmxsDIRX/IsPIsTgUV14ccMsWsVct92OJQVYWdnTJSFQt07wNM92fAY8KWtrrGk/DU3qnAvYwmI60cM94R6mJT9/zkq+NRVTVBZOgAf9aTNT+yGYvaiPcT0k4Gm7yeSuSXjbUXn3SQEoRDfYt2UIgbSERxp5msHdWvGzmNBf1BeAE4NghmB++ni2GE6nd2rE1cAZZKpswwCdjmr49zpTeielnM5tyGAuS8VRw4PB62IvWga5P1UXwNO2hCTyDdfZ+YUNwhPyC6RMfrOaz3XbAgI+wtROdHW+3vbrNYbgeitoR9ujaZIqbIx2aYwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zc+HPUuJE+zo0t8EBG8rma0duDRiDZwNjDhkld9W4Y=;
 b=Nm9425BL8OBzMvLfwb00bAlJUWfLEmxcbr5+leQZ8hOG43EJXvKSykbjNYC1SJPi+9xvintt7oZQB68NCe9u4x9y2O7FWYRZgb6yq43tLpcFDpFAAn+ZAu6NIQszq+dh3Iarq3th35SGspxnNbqy5p3jMsR5KX33vnaqkLsn0JLLQAg/WL41wGnUyQFEbpIFWXartl65cqKk/qgf7Jf2jGkGntBLDEs9rHKZ7s1mHwgYhWD9bJox2WRm+r3KAiPnQ83hJrmeGw6mRCTt+esAZAnrweB++QzzbV337hnSKsosuZAXIoKfvac0rDFignR3hHXmW/SSQlPHd75hP8Kn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 03:24:44 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:24:44 +0000
Date: Fri, 23 Oct 2026 11:24:33 +0800
From: Chao Gao <chao.gao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <dave.hansen@linux.intel.com>,
	<andrew.cooper3@citrix.com>, <nik.borisov@suse.com>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <xiaoyao.li@intel.com>,
	<tony.lindgren@linux.intel.com>, <kishen.maloor@intel.com>,
	<dedekind1@gmail.com>, <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 2/5] KVM: TDX: Track configurable CPUID bits allowed
 by KVM
Message-ID: <atrTcWO8FRz07Vc9@intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-3-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016091422.3182216-3-binbin.wu@linux.intel.com>
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|SJ5PPF20F246184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4115ea13-413d-45de-60cf-08df30b52eeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|22082099003|18002099003|261022105027099003|261022075727099003|4143699003|11063799006|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /bKIsjjmp9aUTveTSHOSPy+PeEnVE4n1SkVCUolTWTVBnzeT+Zs/s+nHuevXY4k7CT9vw8spkPhku/hEazplAsPBsJav9Ob+/1LuPMlJr1RVbaY+bPjX9AOL5iDx8Xwn2VbVlQdgllY+JFKwA8wcADdEJvX1KI9m8WrT8v30Pg6NltRJgdbWD2CZTruQilFQBqkLy0E2WsK8m+xspuwWVJ+KkAUapNQ4yPCbhg+WyHAxQVx4GYvJs5ZirBOA1s67K6M9PK/DA737JwaW6mXUDPFos7GLsPpRBglMNYVDukYJ2qZnRq4VXXrOlW6ZvQFcYybxe97XXBJOKrghyCUB4XObGhnC4asoJX6JlBX7f7/5EtEixG4bbePkNWIzg8FYR70g9fkJMuJdFCZ3YStipJFyYD8pgGJ9AYuc2X/VMfV3LC+StMEIj/2kQFY5JDxoovE1vFqvXvQF/1wATncCzf5IpGdNohY7OgUR2kTbXqJyxIkc7sCicWhDxKm05zGTG6Aph1ap+mv4Yx6plzbo2+2SZarjhdqopkS/560gXBPV4sohxRuFzXCFb5KK7zvnzS3h+et5IypwpEjW21MVmVKKmNVhRVyIM+L73bfVqmllD+95XlED7mjInDR6Cs5yqNv2wQkZRIVcCuGGk09VaZ6tNHhhl48bPOczvj1ZfgQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(261022105027099003)(261022075727099003)(4143699003)(11063799006)(261021121427099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WGSV8/2okKgKxYD3MZU+zgmQlkpO+GzJ/VGPqLJTSVBmACXsPrhphXMMCcsV?=
 =?us-ascii?Q?2l6v5YmWlPXnYH/xJ/o4Ypfx9rapkhh9nlmmm9N71X4Nd/LnBoqzQoFQ0Itq?=
 =?us-ascii?Q?FWkzqUwedtAQB3d6MA7FCju76gm8Th+5WEB16ob42APWFN4HTRI91yGlpV32?=
 =?us-ascii?Q?aD5ackqZXP8sDipEFhto23tpaEfxOV+GMNV62OaZXvyO8hUBuAdcs0+eszYD?=
 =?us-ascii?Q?RtweM2gK68x4Ft0UTWaf6gAWsdZYCHe7g4d8nz0lfMM2cgYOgB4hOea1tbKI?=
 =?us-ascii?Q?4EnIcvSwkOSKJX0010sqgLAl45GgR6GM7hLkbE1Em8A8NGsNW/eZZ/f+bsVK?=
 =?us-ascii?Q?7HU43Nixqn8e+7+Kv5+LE/l5X5Jo7nwoTAsIzM00YK//9MyNmRrUEtA0yUCX?=
 =?us-ascii?Q?QwDs5seEYD5THusARI4KggKhzioR9ZeuofIVnRikoLfCJiEstAUTysSOIcxf?=
 =?us-ascii?Q?eB4//4qekLuoqIKaFcfaCMXlUBFFSpbFKdtGxajYuAlPY0yt9d9MTMNJ/oqV?=
 =?us-ascii?Q?nsCHx5SVy2zv9Wq4IzqSqxEr14OyaYphPxSI/2DqS+gZr8xb/Jn/pf/4kryU?=
 =?us-ascii?Q?ogRQCzNvAbm7/YYmMrkbIx2vF9/Si9KbxljW6KpyCYXNTBkzh38smYrT7//2?=
 =?us-ascii?Q?a9w7evMuEais1+XYQ3oCkFs///I/4NbsCadyA20B3KqvFozhu1NeXB0rZPLP?=
 =?us-ascii?Q?s5V3w+8UIxoA6Y4/ohaQ5GkvXRRR9CGeCAHYoD0O90KtxLb4zEwgIFhATZSV?=
 =?us-ascii?Q?rcPPg7G1tixLJXe+bK6e/kiEq76a47oxiDCeH8DuCvE1auLtJr1YsdskknU/?=
 =?us-ascii?Q?3UEvmyLl+oV1cV6AA3sSTJvIoBgemjryxk8YJOuU+VAAnZN7CoEy3wzezQXx?=
 =?us-ascii?Q?zAL/X1esA8YhdOFNeXFlhAC9lvI1fNKFAhOfmCYrbQjG6yHSSUyoXHEJzixL?=
 =?us-ascii?Q?IS9b0IelqwJ06JHu67llXFd4qE9i7rsPMW6ITeUQgPfUs+sUPUhcU+w63AmD?=
 =?us-ascii?Q?NhbnJdyaEOGNpRtTxZ6rI+DgAm8b5lV8/HKgI9amg9AVAnOdIg1b2pZpivN9?=
 =?us-ascii?Q?ibiwXX/4nL6EoIOC1i0ewUcnntn2ci9asr/flpROG+QkSWXd7QUdyVnoauKD?=
 =?us-ascii?Q?ThdqoXYZCHyR0JY3YB0d4aQ0IaJnpXaPWiWZvkJZmuZfwJ5N+zIw4VSZLYKz?=
 =?us-ascii?Q?g4X3Lax98YLmWj39Ciy7iVfkmdIqcL0FtkiAITr4hQ6wCPi9QDaPv6TtqdNX?=
 =?us-ascii?Q?+TVqEiVMZkSI81eE74fcn8qqmy92JT3nHsi9/5WN6ShJkbh9vkdKx0SccYK0?=
 =?us-ascii?Q?0g3pvPyb4/61koUug9oqWPTgg+UI3jjKm3jnZGFoE2dx1f3Gz6Divp02bLmu?=
 =?us-ascii?Q?jNLpT9y6wIvL3RRJ5S3+U4n0uxsckXXuw05F3dVFf1EDVEoGmzM9rZwxy75m?=
 =?us-ascii?Q?XDxHpLpCTFSVODcP1RjXMx5Gqaq3DiRCCVsIQkdpmOGibE4DThnSBfMr/VWC?=
 =?us-ascii?Q?d/1h25ZEiIbNiGnyiePYme1J2ijdynSLWmXHp33IBPxP64M14eS5OOuoHR68?=
 =?us-ascii?Q?t8xSYPPIBRbfj2kqlcabMqADwMXTB61ZVhDgx3UjFL3srDqGAvr+nbVWmtsJ?=
 =?us-ascii?Q?jrchoKFQNfTwFtZJjTXKEOL/6qSXbS/35g/v4cju3B4VX340J1bhK3qeajCm?=
 =?us-ascii?Q?3+Ftos2Dc7d/TZUHhbncFGUE/V6dgtp2V5VCsDVf8LLYNoXHe84vWoN7bgfe?=
 =?us-ascii?Q?zdnEvPu/CQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: op3kpXvt8u1KLDsOz88b3+Ef/Ez7koRq2xNH7hsc08J6D5VaN4IJjz15CavxWHXd7IwgjhIQnpSY1EvQOVVduPjM6OaQ/NXuUgnjbf7XNu0fji1jWxyCDafps6IyiiHc7737ZYI3zDqNuz3ULXDHXRYXeubRx3eXhKXD+PdB2/xRlkT67egXRs4/iH4NP0lt/EQruXWjgnNhh+xx8NCm0afQk6FP3VrabA8NYJV23qy5Ox0mU87/1hbCXQPKPOHq0ghyZrZipDhx3spZrESN8BcF98mjAcCTE1F+DlHt42Y0OAv2u/Q6O0nLxaQTzsxFji1Oy7lEAIDKOWCnaA8d8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4115ea13-413d-45de-60cf-08df30b52eeb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 03:24:44.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ggbCEyAVAkd4P7ts+8zd3w6AuVFxX+c9nNuMMTpQJrgnN2RpI/aFQriRARie+noJ7hcuLcBuQ5K+tpQO+Wsig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 05:14:19PM +0800, Binbin Wu wrote:
>Add tdx_cpu_cfg_caps[] to track the subset of TDX directly configurable
>CPUID feature bits that KVM supports, and initialize it during TDX
>hardware setup.
>
>The TDX module reports the CPUID bits that the VMM can directly configure
>for a TD, but KVM can't blindly expose every reported bit to userspace.
>Some features imply additional state, e.g. MSRs, that KVM must context
>switch across host/guest transitions to avoid corrupting host state.  The
>existing hardcoded denylist can't account for such features introduced by
>future TDX modules.
>
>Aside from a few fixed-1 bits required for basic TDX support, features
>that can clobber host state are either directly configurable or controlled
>by TD ATTRIBUTES/XFAM, which KVM already validates.  Thus, an allowlist
>covering only the directly configurable bits is sufficient.
>
>Organize tdx_cpu_cfg_caps[] like kvm_cpu_caps[] so that the allowlist can
>be built with feature-name based initializers.  Directly configurable bits
>that aren't feature flags will be handled when building the per-register
>masks for KVM_TDX_CAPABILITIES.
>
>Sort the directly configurable CPUID feature bits into three categories:
>
> 1) Features that KVM supports and tracks in kvm_cpu_caps[].  Use
>    TDX_CFG_F() so that they are also capped by kvm_cpu_caps[].
>
> 2) Features that KVM supports, or can safely allow, but doesn't track in
>    kvm_cpu_caps[], i.e. MWAIT and HT.  Use TDX_CFG_INDEPENDENT_F().
>
> 3) Features that are obsolete or unsupported by KVM, and thus excluded,
>    i.e. EST, TM2, CID, SDBG, XTPR, DCA, PN (PSN), ACPI, ACC (TM), PBE,
>    HLE, RTM, CQM (RDT_M), RDT_A, PREFETCHWT1, WAITPKG, TME, PCONFIG,
>    CORE_CAPABILITIES, RAO_INT, FRED, and AMX-TRANSPOSE.
>
>Excluding the features in category 3 shouldn't break userspace, as
>userspace is expected to consult KVM_TDX_CAPABILITIES for the configurable
>bits before invoking KVM_TDX_INIT_VM.  Nor should it break guests, as the
>features are either obsolete or unsupported by KVM, and in the latter case,
>a guest relying on them would already have run into problems.
>CORE_CAPABILITIES is a special case; it will be allowed separately to
>accommodate its legacy fixed-1 definition.
>
>Future changes will use tdx_cpu_cfg_caps[] to filter KVM_TDX_CAPABILITIES
>and to reject unsupported CPUID input to KVM_TDX_INIT_VM, so that directly
>configurable bits introduced by future TDX modules are neither advertised
>to nor configurable by userspace until KVM explicitly opts in.
>
>Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

Reviewed-by: Chao Gao <chao.gao@intel.com>
