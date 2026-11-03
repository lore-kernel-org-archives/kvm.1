Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793696366;
	b=CatzZRMTAMuJfzhXcoH6UCjKvjLSkp8w6hK8NaVVbyTpRo82xsFf5xtPuvTvZ2Mj+23G
	 WaHwTNrS0vsWJzhuXxcnpDbdfkcGAuxa10fzeYhPkfFnaMOjDrDaPT0SVu01Qy+autY16
	 PZS/JQkS9BP7eNiKSZfDHl5NVeAglchefPgL1F4gvsnBWfLJWxZs2pr36YkFM57bp9TmA
	 nfl203pUpoEPshqGAGVs617uAJI941tUVsY21DxUMq65JPy5rz3lZs1im3tCaEaxTpj0D
	 KX/+NrOrS+pP/lz/uJyzdXYGyRFCQ146KsVLW5moxmJ9KdAkFdA1VMqy1JREoS+Gj7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696366;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=sVsFDiC4Psuu8gpLH1EHDRG8oBGi84X9amRLYO9m1h4=;
	b=HyVPpYyuzNG9z1jYOmCAnEzSTtBp9ORNjVuA4SgldO29HWzrCqHqsUspgx9toCNBGDMu
	 z4F2Gz/YDrLQXRHsvTk5GxzkNZwHTgHHGuo3phu4iNtQ7GZRIuG43PoP/sSsATebwYl7n
	 Q7tlGWgOXBNW+4Cni4jVgiBQtq8k4VquU+/7YpOJ2i4T2etT30wIx8jVxsErSlGlp1Msy
	 NbqCHhZOUGx+662nHDdyHGd4IH8xmKlMir86lIFq/54qqheDHwPHJPPAVOBfEjS6KmRJ8
	 j6T6g5hnDB1qvvt+0MPb718xycllk5diP54+GUIoEwWQhB/vS5prP8V0axMJrMv+uCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8WQ+ofo;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7D606A326;
	Tue,  3 Nov 2026 08:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B7D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C8WQ+ofo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793696366; x=1825232366;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=XidyXXGIPcADK+/o9ovIrcRn1fNJHgoKEvvy74yPQbE=;
  b=C8WQ+ofoi6gyhQEqKd+CA4BqmTPi2R/c+XcfPKb4xoYsRbp1K86Bn57h
   FOzGXnbNZ1ERSH7DuoZeEApDN14rCAmd+vE87hNuObNJlh7/xwXDg7pIo
   V6IZ6gS1KiNLCFJpHKmotM+sKaaNta4gZcoXT5Tu1+1H3gschQOJmq414
   8JSq45yoiapak3sU5AMyIiIYYkG1maOvri3Iy8Yo657Txpb1uSnm5m6pF
   OKz64KXLMdZjnE3tnOZGFWPVu3AVgtOm4lXymhouD+bggfsLQMfijIHG7
   XNPViavRpV+qyfFCF7t4ayt5piYvtx1QgsX4HIhr3RMrtelHQloacZNj7
   Q==;
X-CSE-ConnectionGUID: FIgKe/FfTbOSt7lBkuChqQ==
X-CSE-MsgGUID: HsG12ykZS5+xYQ7oJyrgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2319375"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2319375"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 00:57:49 -0800
X-CSE-ConnectionGUID: V+kkPV/rQCqJYSLDD3yLMw==
X-CSE-MsgGUID: 3QeSjGVHT9G+2irX+e7rxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8152490"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 00:57:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 00:57:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 00:57:47 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.42)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 00:57:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajQTLAKgZyytBNAk7rsCGlFPbCBf3Qfgmg1qg+XLT/iDQM815LIxnQlgQxEL911/PTbULOy9nLbNLfVOxD/E5xjcSomxY71Uyn2D6+yZZCNyCHESJ+gK+EDoXVEKzKtmhh4Zp5IskKhJkfOFH/w5OFRogk3Qca7pqctsXGMc1vkoq2XIIsY+zoME7PkEuELtqCHRk8qQayt6+Bh9f6KJluXXC1xibcIN0RVwj73Z6QRlr6cCaWjiy0+OQAZWZJkTNJmivp6karClWDr1apKZo3jc9r8PDHKCoAXMiv+/NHSC0TiNWVfqaCeoGJyXawEU9L1/bQS2mVhzRXE4PtSZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFkYlFiTTerDlRp9NeLc5u648AW1LqHejgtaSsOB1Kk=;
 b=eu4x3xwMshShEMHbK3R/72mkULKS7LQ9TQxFWgHjLCBgeSPVaC4WL2QPOHUcN6ZG/lCnVsLY42tll7557gA+5H0JoY+WFMfMHJ1fN1zOj6D6bcR7t3wYGw5gjYsM4eAbq6JpQU5kNMPinQeLRheJ+wGL1OUcyvSERpv33qqxgPO5gIGJGZx0exaW+FmtYHATFBwb3zh5hbCBeFEN1hJs9cEBHwmjoQZRQFaDBOH2a0VmRjfvPsopaU2JQnZWPOuKyF5Orqp3Gdw/9TeQe+6b8G3vM2yDV6h3ujnH5bntrsBSVXpVv8vqjmBBySSpIYntMeXMTI/G/uQt4TjjhKSq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by CH3PR11MB7763.namprd11.prod.outlook.com (2603:10b6:610:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:57:45 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 08:57:44 +0000
Date: Tue, 3 Nov 2026 16:57:34 +0800
From: Chao Gao <chao.gao@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Van De Ven, Arjan"
	<arjan.van.de.ven@intel.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "tglx@kernel.org" <tglx@kernel.org>
Subject: Re: [RFC PATCH v1 2/3] x86/virt/seamldr: Support large TDX module
 binaries
Message-ID: <aumh_q8olQPwH0pe@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
 <20261030085304.3886520-3-chao.gao@intel.com>
 <396de152b28fc1be18bfd61fd0ee7501c188e661.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <396de152b28fc1be18bfd61fd0ee7501c188e661.camel@intel.com>
X-ClientProxiedBy: PS2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::18) To IA0PR11MB8380.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|CH3PR11MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfa585d-8d8f-424a-237a-08df3988866e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gM7kUdHYuWhLQnM/BtWKUMYeOljHm5K6Qo8UeH5GPtDSttBsrnLV+gBTlFJkh1oPHhd1vWiLVZnqt7jKAfq+ZVMg1+OqK2ccJ1tR5+ZisLpzHXikEkY9mD9wuFZAOksDqKpt5xaDYl9awTHjZBjOYFuJgtQdvgYg8Ub4JLP6jLH9vahOvU4p8okIa3DUh0u3+HFZCYwJ8XookmnQbpkKTzMr9muTrajDejkdRhpdI93zj8Zzao78qOQ2ZCqy18KGyaffe2EFlGV/iit1Cz0LOvVUQNKQF3TNtgeZ5aIJq2YAZvvEf65hv+/9fYnJ7QnMeNGvJ/wFB/2VNqRbJwckYYSI/7lNfjaXv2cEx9VkrzqapShgnxcNkj7fHlAiNFSTaZuoTCHQ2CYuIxDauiZlGaN3r4SWHDAIiRx48LOXpk6CZ5pAawIzGYuXzLCnUvQ7yrP88e3DGccLRmn23+siTcVdSl4YNmtoilA/leoFDlrPVuN3H1ta3cO1UEAbe8hqWDhEnvl0Rwu+KXQ8mqcWOB0G0J1TgpmgdaLzsHz/3hDQV9Rekf29p56m2uSxJoXegw8zg6Nr4/Bh3Xd9wWpWAMFC4xs+sCuE17FrvAn1nzbHLwmKHJczkpGgZtVhn+m5tmPeiHt3lOfGcQ4543Jpy+2sNRdYnqJzq4CjymxLY4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ljlm6Yw6Lxwdzi+Ok0Z4aBup2toOzGEzoOJmK8ECpm9Tk9wOO4o1/gwrbz?=
 =?iso-8859-1?Q?r+MOyzT5L84I059w0Mi5vNH+F09ZrmXTV1svgygghNEba75ll/2ueNHY5O?=
 =?iso-8859-1?Q?76a9N0jz6iYJGmh3JjSU0p/B2gGOjTOdZqjqE1r7n/5kzrylRWxYaHSFRg?=
 =?iso-8859-1?Q?izlYt1DeVjlGP+CoaiTlDz41wkZSlb7rT/dPUt1jC6mgFEVffQuWp6vg5b?=
 =?iso-8859-1?Q?WTYsSdXuhOYcT2Dm4stgffaIVU0auKJv4zRHp8CVgDuXZX1vmTQBgqo1YU?=
 =?iso-8859-1?Q?w4dUHyx+zEgozDtip/d+J7vPI0w0FBzEgQz1pyBgHQGvuCx6FzpgoCUQ/2?=
 =?iso-8859-1?Q?AWDlrhyXDhH98kqOCDnAD9Tk1Rup10FFf5svkalwgMZH+q3Z9Bfct/aYo/?=
 =?iso-8859-1?Q?NEbVAjJmGOWVOo9UKBmql2tEpYjhQwgUv25YlQr0yG95x+gBd/4+UwDpB9?=
 =?iso-8859-1?Q?FALAYIItlxXfsPQZvmEoXXXb/TiHT5H9ACq1HtEDbzxgon2D2wjQPD1Mhn?=
 =?iso-8859-1?Q?PHrf16YvWfgXiYIUFEkVryWoB1lKElW3hKMz5aOTYYZ/bwSTs9XLedosiN?=
 =?iso-8859-1?Q?m60XKQ2jq65V7cA4smfcztcoeiwKFHfChYzPQQ3c4AlSkIqKjoHXByHMXI?=
 =?iso-8859-1?Q?X7o9qIQQFbQdrQmVexS+zklHP4XpcT/9CbQgIXBI6qabDsmAAppTQR8aXv?=
 =?iso-8859-1?Q?dCGJOnd4l98vzXAHSNb3bsoHpUhegFFMAtIauA0iQN6mYyFxCgnqbdZ9md?=
 =?iso-8859-1?Q?Te28B6yl4jy3k56nI9BGyG1UGeKW9My08cM++Cfjwxhw8pB1Od7NujvGyX?=
 =?iso-8859-1?Q?hiC1NUodbNHjzg47o5UdsNEbUVUWCWDKWt1K8uF+4zplkZABDwZsmca4/H?=
 =?iso-8859-1?Q?9/m2fEgK575S1Q4yN0OTAU0/2qMBiBI8HiIhXkVzJuQSYfg54FQ6xjMox1?=
 =?iso-8859-1?Q?plYowIsFY4b9lcXvU5wbCa9JpugXvQU6PP63CCTa9oQAlad+xBmL3nXRGJ?=
 =?iso-8859-1?Q?dBCXzyao0mHnye0jsACJpxT1ry8EPLxxnlP99pj2LYruBJriHa7+Z3r8Xa?=
 =?iso-8859-1?Q?gNePnTpdOl+V9sJfpjEH4gReeWd+KnrlKXXrAJ+dTPNb6NzgsOPUCO752u?=
 =?iso-8859-1?Q?FzOR6ojW5gNqaemQKdFBnPAYGDm+aJFJbGQ9JUTyJdwC3nzKXAQ0ZYgyYw?=
 =?iso-8859-1?Q?/UDeZHv8jvYqAyGYCrt4NqNj3jEN6i2FFkQRDHsR/LovZmyJdBNtmFiI/w?=
 =?iso-8859-1?Q?K2j8uPC5xEEQ7slbfONlTFKqbsOYtByuEB10iBe52eE22ubPup0kCU6iYZ?=
 =?iso-8859-1?Q?Lut3pRdkOSWiReEaZx8DaWPGugTC5TJlvUk7fenA+scts3xQdWlkeWpAws?=
 =?iso-8859-1?Q?2YEkhZJ3JxDFPbfHIgrLjvGcX6oGpzc1JMSBXWLtn2Gu9VUUFBJBTGQfDE?=
 =?iso-8859-1?Q?ztz06OPlJIjrEi5B2S4CE9hrriTyOrQ50dYrDObI7me1iuYWBIJ/D4GtKC?=
 =?iso-8859-1?Q?6Dh3FBbCyLFTKKAcR7YiBSBhSWIqxMkcXfY8WTmM5RnsMqXjsgLK52261k?=
 =?iso-8859-1?Q?6lgiuBVsXrg5CxamO5On6WSo6l+KtnITan9fpfQl5IvBLSLOYwB859dZWQ?=
 =?iso-8859-1?Q?By9ugpnZ8wyCf9lOygH3UdDPbKhQiMKTcWrGvL9rVc83/qc4tjK9dcGYCn?=
 =?iso-8859-1?Q?5mlgLUM3QNg87mqlE4QToD5Bw/QSd+TYvdICYcDkeP6lEr4CGxRLR+4wNs?=
 =?iso-8859-1?Q?hQDnoTIPANJXKRKsbjfUoDSyS4VLHHMjEgNPgN5JxKCeomFhMN/bLgRJFH?=
 =?iso-8859-1?Q?/lv0s4xhbQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: eQxNZZFksSxFqYAgbMtM/jWJ6Yx/k4qASsrgzyvyoCf2laFgawRAF/aGPKYUG3yI2Me0KLTDfX1g5bz7RDW4dWDKE+rS9v/PMvlWkkg6r2tBCP6iqe4BNLXGxbVMIQau98vk9jjqgaae/HzCazNXomgxRjPYyVwBWvUesuM7TTJuPPR05008o1HfVDU+wrUF7zGPkgRC1uDAMGuV6TwvTr7yRl9uIXiYsboHxIEcZxNefi4XiHie5rL9POX341bmhjPt2S6MBA7RvAFJOUL5POk4bdn8X+FOf+Y4gdmq99FOgW4f0ncf6pUGJ2v5Ic8R5v/LWFPCDcgWYvf5d40ngg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfa585d-8d8f-424a-237a-08df3988866e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:57:44.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNXrmJ58ePPj5NuiU8BY/3z0vkO0l2foHfAHFGLJtLIh03tYCl1Mhn1fHBs/K+ocZu33O7Wx3PvPiHBYKfQs0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7763
X-OriginatorOrg: intel.com

>> +/*
>> + * Like populate_pa_list(), but skip entries pointing to the next page.
>> + */
>> +static void populate_module_pa_list(struct seamldr_params *params,
>> +				    const u8 *vmalloc_addr, u32
>> vmalloc_len_pages)
>> +{
>> +	u64 *pa_list = params->module_pages_pa_list;
>> +	int i, j;
>> +
>> +	for (i = 0, j = 0; i < vmalloc_len_pages; i++, j++) {
>> +		unsigned long offset = i * PAGE_SIZE;
>> +		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
>> +
>> +		/*
>> +		 * Skip non-zero entries. They point to the next page and
>> +		 * are populated during allocation.
>> +		 */
>> +		if (pa_list[j])
>> +			j++;
>
>We know what position in the page this should be right? Can we do some modulus
>and skip it that way? Feels less hacky.

Yes, the link is always the last entry of a page.

how about:
		/*
		 * The last entry of each page points to the next chain
		 * page.
		 */
		if (PAGE_ALIGNED(&pa_list[j + 1]))
			j++;

>
>> +
>> +		pa_list[j] = pfn << PAGE_SHIFT;
>> +	}
>> +}
>> +
>> +static struct seamldr_params *alloc_seamldr_params(u32 nr_module_pages)
>> +{
>> +	struct seamldr_params *params;
>> +	u32 nr_chain_pages;
>> +	u32 nr_direct;
>> +	u64 *link;
>> +
>> +	/*
>> +	 * Number of module pages that fit directly in
>
>"fit directly" feels like adding jargon where there doesn't need to be.

[...]

>
>> +	 * module_pages_pa_list[]. Minus one as the last entry is
>> +	 * reserved to point to the first chain page.
>> +	 */
>> +	nr_direct = SEAMLDR_NR_MODULE_PA_ENTRIES - 1;
>> +
>> +	/* Calculate the number of extra chain pages needed. */
>> +	nr_chain_pages = 0;
>> +	if (nr_module_pages > nr_direct) {
>> +		u32 nr_left = nr_module_pages - nr_direct;
>> +
>> +		nr_chain_pages = DIV_ROUND_UP(nr_left,
>> SEAMLDR_NR_CHAIN_PA_ENTRIES);
>
>Left pages, module pages, direct pages and chain pages. It's a lot...

[...]

>
>> +	}
>> +
>> +	params = kzalloc_flex(*params, chain_pages, nr_chain_pages);
>> +	if (!params)
>> +		return NULL;
>> +
>> +	/* Link all the chain pages. */
>> +	link = &params->module_pages_pa_list[nr_direct];
>> +	for (int i = 0; i < nr_chain_pages; i++) {
>> +		struct chain_page *page = &params->chain_pages[i];
>> +
>> +		*link = __pa(page);
>> +		link = &page->next_page_pa;
>> +	}
>> +
>> +	return params;
>> +}
>
>This all seems like more than should be needed.

Most of the complexity came from sizing the allocation exactly. If we
over-allocate a little instead, the size calculation becomes much
simpler. Making module_pages_pa_list[] a flexible array also removes
the need to treat its entries differently from those in the chain
pages. And linking the pages while filling in the module page addresses
removes the separate linking loop.

We could even fold populate_module_pa_list() into populate_pa_list().
That works because sigstruct_pages_pa_list[] never reaches the end of a
page. It would save a function, but it looks a bit hacky for the
sigstruct pages, because the spec defines links only for the module page
list. I am not sure which is better. Do you have a preference?


diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b1137ca6150d..cd4a00a7b02e 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
 /*
@@ -48,11 +54,9 @@ struct seamldr_params {
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
 	u8	reserved[104];
 	u64	module_nr_pages;
-	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+	u64	module_pages_pa_list[];
 } __packed;
 
-static_assert(sizeof(struct seamldr_params) == 4096);
-
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
@@ -143,6 +147,55 @@ static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_l
 	}
 }
 
+/*
+ * Like populate_pa_list(), but skip entries pointing to the next page.
+ */
+static void populate_module_pa_list(struct seamldr_params *params,
+				    const u8 *vmalloc_addr, u32 vmalloc_len_pages)
+{
+	u64 *pa_list = params->module_pages_pa_list;
+	int i, j;
+
+	for (i = 0, j = 0; i < vmalloc_len_pages; i++, j++) {
+		unsigned long offset = i * PAGE_SIZE;
+		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
+
+		/*
+		 * The last entry of each page points to the next chain
+		 * page.
+		 */
+		if (PAGE_ALIGNED(&pa_list[j + 1])) {
+			pa_list[j] = __pa(&pa_list[j + 1]);
+			j++;
+		}
+
+		pa_list[j] = pfn << PAGE_SHIFT;
+	}
+}
+
+static struct seamldr_params *alloc_seamldr_params(u32 nr_module_pages)
+{
+	struct seamldr_params *params;
+	u32 nr_pages;
+
+	if (nr_module_pages > SEAMLDR_MAX_NR_MODULE_PAGES)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * One page for 'struct seamldr_params', plus chain pages that
+	 * each hold 511 module page addresses and a link to the next
+	 * page. Ignoring the addresses held in the first page
+	 * over-allocates a little.
+	 */
+	nr_pages = 1 + DIV_ROUND_UP(nr_module_pages, 511);
+
+	params = kzalloc(nr_pages * PAGE_SIZE, GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	return params;
+}
+
