Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF09C2FF;
	Tue,  7 Apr 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563649; cv=fail; b=tm+GoTnwB4nScXget54ehNCOtBE91HO92B5wU6/ddZ2KRkc18ju8OQciGmgNGcHv9M/Zk7EjkfXGpdqI0V7y6bUG6tBq63+L7qu45mJwg/O9irBNz9pA1lFG9LsFytHBQfpP7ayrDkkNtWdy9Dr/6MSP7eJquXhDB89OwqfTZKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563649; c=relaxed/simple;
	bh=MFMbd7JalKZbw1PzuT23DIoYhl6qtnQdL0HPOF4C2yk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DmrURnmth/mfRiLkJF/r5TG1fjWj0yPS5h9bTkkPay7L3T/0ecfGvnftIa3w0KoqoQkwfbWkT2fCYl4rGGOm5JsODh2xOABV0thfIBQNa9CePuqENJ73SGg5ogDGKr09/9f6N2HwnbF2QQELDDoLSQVwawCpPYorjiLaye2iJzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY1h3gj2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY1h3gj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775563647; x=1807099647;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MFMbd7JalKZbw1PzuT23DIoYhl6qtnQdL0HPOF4C2yk=;
  b=nY1h3gj2HLDtOo3HH8PMVDvi7VLw2rXgCkky8DkvSER9+FGLqIxOEWh5
   J5KyVAH7CM4uZoT4N6TzRjW3spug+vRw+e3bwuz1QuiqsLJ4jneJF4ywm
   330F9uiX2P/UYp0eB0OnWzFcRgQ2wzTkWvHDLpbSIjiRx4z4/usvsEdiH
   jF7aAZhNAhecIYTM8QHYHxEPCm6yEV/goo3MayKrETCzp0yje7avgy/eW
   LZsioD2QFlSAbKDJHHXilGYfbExpzTJHsXiPhYVpdnL3trFJ08NUV2n+c
   7CoCnLFjzYaRKsgf1B3GrVwR3NmpKDwZlHvYFh7s9zhVoJrA1Rvbk38NS
   A==;
X-CSE-ConnectionGUID: Q1ORo1o4Sp6d/ytTnZev2w==
X-CSE-MsgGUID: IIWUdYMYRgWH+knLcY91GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87151180"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="87151180"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:07:25 -0700
X-CSE-ConnectionGUID: UENmb3cpQQOrM3q+ZAPl6g==
X-CSE-MsgGUID: 9X+ao0scTf2+RQMzR1nj2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="266134142"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 05:07:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:07:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 05:07:24 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 05:07:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5VYGArp5tKndSdIWmuvustituUdjpyCR7NdMvvBNXSkxYmUg9mowpFycbdgQcD+jMh5RARl8on8GZriuQZDv7LYkRUWVYhRq0RWKZYj5KR3ZSeeO6b+qJgdHn5/feJI4Z6K4GMRMzfxI1fhaY2VxCEl0Mm/lPNdxSs9Tyl+L6fGCDD8HYy+8m2asCeag1hwRWhp5hcjcvjbtbcsLi8pqbZIDLunMWUxPNoKVem3xTo8fMgrm7skKYtSfiYCx0WPXycTXro2gTfWTgITqQIU0PgxRwzOEnTJeiepVkno/GOyuK2/fDrZQl2nwG0aMQXKmAvEaC6jrShd+lUdMh43qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT7LikU+S1Ihod1jLId0jMh2yZ7TUpn1nKVqtRCEKAU=;
 b=Jycq9OfkjUJzhC4L5RE+1x4kPL6DYgNJJJfR0gCBOAgNvQwqsacnvGDUSmbvrJxVfs8qmQjWiszzfZkNBc8H5EaESBajbV5wtYgWYEMBo37Dutl49dDEsE0WAeuoEjOvSWoKtEvhjxDlzh9XCRMP/+01AnVorBHJU8PNycmVxJWPUtLjU3c8dzNFDMaBT3qxuUtf2hK/X9SfHjxo9bhHzODYZzNmuJKiFoPqHATLe5Mh+CAni0iFP+RnQA2KPaEQP0WghCTH6TWJRWsK3kTgxsxyh+OBRNKtoHzb7kDLagZdKQ/qFbTvdv4pzE2RXwt9XYtkGdjbGhw5Ng/joy++gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CHXPR11MB9649.namprd11.prod.outlook.com (2603:10b6:610:2fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Tue, 7 Apr
 2026 12:07:21 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 12:07:21 +0000
Date: Tue, 7 Apr 2026 20:07:06 +0800
From: Chao Gao <chao.gao@intel.com>
To: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<kvm@vger.kernel.org>
CC: <binbin.wu@linux.intel.com>, <dan.j.williams@intel.com>,
	<dave.hansen@linux.intel.com>, <ira.weiny@intel.com>, <kai.huang@intel.com>,
	<kas@kernel.org>, <nik.borisov@suse.com>, <paulmck@kernel.org>,
	<pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>,
	<xiaoyao.li@intel.com>, <yan.y.zhao@intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v7 15/22] x86/virt/tdx: Restore TDX module state
Message-ID: <adTzamrJOOy+fGyF@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
 <20260331124214.117808-16-chao.gao@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260331124214.117808-16-chao.gao@intel.com>
X-ClientProxiedBy: KU0P306CA0070.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::13) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CHXPR11MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3702f2ab-676d-4823-e13b-08de949e38e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OQ9Fu2BY15gj9WMPAc0C4AOz8r+0KWJNQRwTri8zipIAsloHTT3dRga/O36YsPy61SmIR+6L6A7k/OsGamSucJrcXUrC0e39WoesB7RmEhAybuGKI1/1JihZiqJXZreMMkHeE49scUhpl0r9rp7kXi3Btn+RQoYlkL1/ldMaXokhbZRXOogfbdQdALoHHYaa7bbXHtT58uj1qmV6BS9PpNAz9xx9h2K+ryL7y+AwWhHiQYWW2BsZbJFEgMRZBXCehb67AcnkD6fYEPZ/LoUIUuDyd4VclLiMhxdN4Wt/OlFrcyFNSLK0lLVmpKOaLKqtpuvEAsRhWsUwAlycqtxQG6imurrix8HnpARBZQnHLfvFlGG1yLJyAK39utAd1MSRmNHbtc63s+oTTTdJ7z9Ta2cAvTSohlU5BPkf/BUMDv/8lS3babCNImNwXnNfFWLVSLJtht7ko5VQDVAoVAJpG9Ibt0Sfy08xKLSTwEqak9PE7vpBpXXTkk1PsHiC5M81WvygBEtjm0KumXkB0hBKE3yWMQY6GLX1YkEBLDFU+szaV6c9afJ4IRiMqnnOYq8Jim45R3XtAjIo8McVlTl4hxfAFiNa2r1BzBHZTUlcutR61VNXcKc1dN5DcrCzs0wrnCixoB+/jfpi8RB2OvQWdyc4wYrcOGx3yz6/bs6VIsUrexKECKx9F5EKj4cSQYYPUCmpqbcyM2A4XJwMeoc9cHzs2hh2R1akVHUoQCOcRJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHD9T1Ihe5lsCDMNgaPoGaQpCzeBCtYPwRo8Tf3z92df6Kd6JXdgqpVOxQp2?=
 =?us-ascii?Q?qM68P/wDX4FAmEXTrrAwpgyVYRXweqAOeWFFsvNiirxZNRj47HTH/SS0JEAT?=
 =?us-ascii?Q?FBm/gSRAFcKvXIWMon5wKjMTlPCsRJ0glhKA5uwilXKbGlXBq2MskWA5CAMe?=
 =?us-ascii?Q?nB853sO2/dfxBpDI8KmJ7/1sjHgRixC3n1a384h3Co9l0frxGdDa65v3eeCa?=
 =?us-ascii?Q?yMVGkklRvjdfslOqJjmDo0aKYdUxSh/R2LzJRiqgih4zK9u7X45+cNUskmhV?=
 =?us-ascii?Q?d/KomqgTQSU6BhzLD7JOtzYmTdpUhxXnB9SZ/Ntft/GbKyRONju5m/j6nbBR?=
 =?us-ascii?Q?w9SBzDG1TxXskeYKsDy46fVo3OAmjNJPc771lQCEQg13QKX6e20UU0cbWL2U?=
 =?us-ascii?Q?mPp3KCI9YQGjlFbrp1gAYG/BJlJiiNG6isuL2sUuPHxrgVI6WEwehKAEzHs3?=
 =?us-ascii?Q?6gc+eoi1fKfQg4lcr/hZxYa8C8skNW+yWlAuZ9RQPUzEF6CQrV+CaD1KQQMB?=
 =?us-ascii?Q?0S2wgVJhTsZ7jk/+/9D39+T19mPcUHhR5Og8iSDoizULOAx7axCC5DfDsZ3d?=
 =?us-ascii?Q?+dx+GUOFgdLkDcCuHc6oxCWFYn7l1pMtP7yGdslU7wDIUPcAFJN3OQMqWG8P?=
 =?us-ascii?Q?Q6XiWaI06D/7xyFAi5NfbWhjW/iEFbrYffd7y5/6tSLWB/wEcfJJp/PCmFn2?=
 =?us-ascii?Q?Pl6v4JcF65jdOLKYwKN5mlcH3QYCkQK8ZwSfrKvOObIrtJqg18KqvKHumnbo?=
 =?us-ascii?Q?dZrP6dMvz7xs+RDqGq9Q5yyq9WDxoHlKZN36AUA5yUya9d1Lh1Ljgvyh0Qcn?=
 =?us-ascii?Q?9pb4R6YAthmfQ01Yc7Ex5mqJD46iNe7I57KXz7OVKiwSkfg0UIHqbyDMfn4Q?=
 =?us-ascii?Q?U+VU91R2Y4tcTZnpF9Ztt3etUwih6Mebdrz/s9qveqIhVrN4Aq52AiHnP5zk?=
 =?us-ascii?Q?IlAGuzu+T9hMbkoLUBf6awE/qg56SL6AteX7HHd876XAAJlatQSM1HM6PilH?=
 =?us-ascii?Q?AkvDcP+wshQBrRZhxpUZrfNbrIgMmt+8USTmKlTJXs2ggYvF82nRt7E724OB?=
 =?us-ascii?Q?e8KLJpnulRcP4MpxYWB2lC76OCga7HcPchCU8Eq6oNIZ4A+PM1OumKmKMe7x?=
 =?us-ascii?Q?QbkjHX885dV3HiMHIK3VQE91Eo1n3o0aKnM10sX/sv/w67enxWSBFdTW6DmN?=
 =?us-ascii?Q?lJp3ltNtnGYmdebsyoUb4TJRrD9KRf7y66Qb6jwePtQTV+nVcpJKnwrdoGWR?=
 =?us-ascii?Q?SHgTNP2l1HtY4n83I+jsz3lTRAhLui2N/2YqdxFvRUm6roAYlkLncx0QrWZ5?=
 =?us-ascii?Q?lJHS9QMXlAEBDpXkJl6I2j7EzakBHmSKBIWdGgUN/KHW+CShmlvf2fJe6UwO?=
 =?us-ascii?Q?TP89PWUO4mkKyCAiN5FSu7kiGZFiqbc0+3nEOrJxlShEfsNO31+MXxdituxq?=
 =?us-ascii?Q?3KEbUcohYLamXCDpQBN2uQ9mWFc0ImvGQHoWEiiVNrjIdF8aAVxxVGGLEMXZ?=
 =?us-ascii?Q?XIHr0uO6Dcn8H1ksKdW3Apf5qKVE/kV6g7cL/4FN7QL0oORUXEuILVccWY/7?=
 =?us-ascii?Q?aCEZt5FVL3khgqdYLh0pGNe7DNXRJOOhBeYvJ2pWzE8G/6CBqsV+SsYbBsR+?=
 =?us-ascii?Q?6G3mmlHJItT0MKDte3EIM+CJU+jTDOYYdp4Uixdh/lzRs6f+uavSRM2sH9Dh?=
 =?us-ascii?Q?Ciy4PhOI4xBJqZjqMpeSAAhNrgKyxtnsv9Gd9irmBebuvuwGMSuHuYdirSVa?=
 =?us-ascii?Q?EnBHzNlH0A=3D=3D?=
X-Exchange-RoutingPolicyChecked: HWetOkl4PmTpCz3Tafg2w+F7pDNW7omI8cmghI5jVRCzdjfcWl6JMXVl6BCZ3wMowKmcYYerGV6l6fMW8ECTTBcjY2RAkr85ZKcJPDjOg5mBzAAtywfBxCEdOFTzlOqRmxqFXLUj/MZfsHsBi8ceOd3uUx1OMCiKEipQNYyYgBhcLm2XWbZ0b/s0/ZJIEA2sJK8ELJAU+L0SWr12bY2cGLrC4I5oG69nN3ih49IJE0i2JlnJ/YaFUf9h2W2GwCxuhliXq+pdDPX7sr7rqT+r4L5KC5lYlGdrjabeZZlBgs08bk05/L7wus9rfvTqpymjr4heRU7KZdxXIC9u3v0JyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3702f2ab-676d-4823-e13b-08de949e38e5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:07:21.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJozPLfPrY/qAAl+sYFcLrByXVaqY82gVxcBt4Afknlq7pDWuea3B1H0bEzh0kZZtDk1A9jmsSj9FTPW8hbYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9649
X-OriginatorOrg: intel.com

>+int tdx_module_run_update(void)
>+{
>+	struct tdx_module_args args = {};
>+	int ret;
>+
>+	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
>+	if (ret) {
>+		pr_err("update failed (%d)\n", ret);
>+		tdx_module_status = TDX_MODULE_ERROR;
>+		return ret;
>+	}

The pr_err() isn't needed as seamcall_prerr() will emit a
message. and no need to set tdx_module_status to ERROR on
failure as it is already done during shutdown.

so, this can be simplified to:

	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
	if (ret)
		return ret;
