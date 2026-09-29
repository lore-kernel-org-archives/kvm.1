Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA612367D3
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645340; cv=fail; b=B358+iXYEqDfRe4RO/7JI8pELS43hBOYR7Vjkyj3KQKc8r/h1tmQMJmoHYH926+Hip8VbG2Lczh6iKA33WWsBblpMVDJuGTwuKcZYPWO/fqVLVc+zf/3Mx3dOGoHa76vq/u+afVCk5nIoBScr8aUoxH3tcdfVGzMqCbHs+A7uwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645340; c=relaxed/simple;
	bh=AKVLlAc0LiwRGaFtgkNoHaaJTCuuSK4wLkvZfqw8w9Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GS82HfJ5LXb+P0kJlASxSQ9AC3GYV2hkaXJu3EZPGtESpDXDxPwnPNvLj757FAu8LVm51AfBQaQlYamuRuQ3zUC64S+4/zNffIxInrjRZ4K9RMlKD5czaxd/uxC+2GMYxm4j1uGFndH0xjNX/F1lw5NcZ0DVjXH28Vd4jHhrIs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXPaO1LH; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXPaO1LH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790645338; x=1822181338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AKVLlAc0LiwRGaFtgkNoHaaJTCuuSK4wLkvZfqw8w9Y=;
  b=RXPaO1LHASo+MBXfWW//KjqxlVkHEGn699ff/m7XbOMZyowVB7KzeCkV
   +2QF93YE85pghsQzqVAXAYedfaVZSO56LXT4Dp5W662yNTqJOyuUaX5+H
   BwDp8WH9talheGGcxePDFQdl1p6iwa5ttsdFMgixlR7E0cmgVbtgUpgqV
   dMkyoV+xyNQnIxlIXQCbdcPG3fKQj7LIAADHByP9/OQQfkMI5RSsoYNSS
   7qenMPrtupmaCCv+YLxLTI0DCYfy6489qnI9L+IueoljPznlect+mYf0H
   AiA1aFIDCWpq0Zb4H82BztvbRpfzyqvB8I0w37w5pcP2w4ONjZxlzNYcN
   g==;
X-CSE-ConnectionGUID: CUKC6luATEu3Cg2Q2u4TAg==
X-CSE-MsgGUID: GvKoTko4Tn+X3eLtRwcDzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94236512"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="94236512"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 18:28:51 -0700
X-CSE-ConnectionGUID: XPpj0fEXQtu5GvpdCuK2pw==
X-CSE-MsgGUID: vcx+mdVkSDGPNOCb4GXgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="278576719"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 18:28:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 18:28:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 18:28:49 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 18:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=melcbmykeIBBBoz+RB/HL66TKNQz/son5/OqoYQHPLCHbwWsvXC01foKFBEYaFR44v2htfd6bWTQvb+bk08xMlZwqUlBEhRopGAhq8tkgfPsjU/KxY+fb2SjY+iDPde5WNT7dLu4QNalkWe6I+P5wzKKi8sM45cL+0LPHSRp+3ovg7QzL65pZ1ohbeStB9QajabEUENdZotwj6tOxu3kLJJG6dJ/S8X7K1A+/AH8onzORa9DN02V7/h/PCuYZ/UqtUcKHa4LIu/5xnsvtrkBmMChBWCpQHQ1JSR9aYZ1xCu8DW3TFdx8RKIiUwH31CiPRM41m6X9UQgr3jIyJiaYgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=279bvR7cMTvPUgexthaRWJcaNJX61IobCf5f5W7m5Qc=;
 b=u/i9LaR0WgFlh2Uyq4PgmSXkLtprz/E8cTvJduvryn9KdaU0B6g+gLfdVMjcP+f6WG++9jLO5WNWvcSKGWkVfTu8dgucSk11IO08XbZPeaNIjGZY1/v1CgbgGHWrsd05BoJwbHDQlvQbobQqd4LjwvMbyomqve5CfZOZwVZjKmTaO4OUt4FNmBH2tyJv7Kg3onML1DAdOqLx4+IrHtsFZAPON3sI3XynKmcYmGwPVKuNTqICjI28wYxgbDEWg9RLshZWXyu6XomqEblH4KQkFHtzBc8RDMSmR6m4a/QLua6q2Zx8/bJ8UlVoqKO2TKthH8ggtVzW7avKU/p5eRfdIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 01:28:42 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:28:42 +0000
Message-ID: <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
Date: Mon, 28 Sep 2026 18:28:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
To: Peter Xu <peterx@redhat.com>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Tony Lindgren
	<tony.lindgren@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Sean
 Christopherson" <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SA2PR11MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b5ae2a-a972-42dd-291c-08df1dc8fefd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|10067099003|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Iff5TGhpCZ7dHeOYS917wfa+kAhCHW7ft/sSINYQa2uctLLR/girc7nyRMSWrprO76Ky7FNatBqOuXbqXyqgm8Lk1qTai+szH6VkM0c62PnfWHA38rs/NMU0CsuqyH/8HEg65QNZdJpRM5vY5OmtCuyS7NgAkIMj4gUhTxry86PkL6Sl6fVqWoAyhDh3r6erdbo3YrwjhnamEcaZ78IpvryXIefg7RkROnEQDerRMBTZ6F8TbONllhLZJOfNrEDJus5SmA10nS6/Ko9jrQ3H5rNTTTF0idmslIXiZgCPiL+8ZrFD422zAxQ/Go6q9X71zkMzr2Bs7+2Um0ED5VXbrtiEF1437i3QEctR9WwkoRfCS+EeE5W/S9f3A1ajRSJLzKrQHXExn5BsRkb12zU2a2ELlSsec6BmUtM7h70O1NKPHOWaI6VAuRO/QsbHSqXDnqNNuWgbFkxmKGt6LYB8lfC2Z9A2AAYWpW4aRR9EUiXXu0UnhlhNvBWkfyVuj4lcY0bH4xIjeE0maMRDAo2ZBJnGy72MGMJ9OIUSGORCAbJ0kivfDvB8Ixf7fyk9i/9zaauC7wRNSi3dzVnv6nDRYkYn/MlDjXdvBm/4z3twnRp4NFBnbwlhATyuOWPp9CmSUL4/ppUf7wQcyjkrQVglbjY76Vd+cNfU6WTwnEDOKMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNsLzR6emdBbnFrWGxhWUd1SFIvaEtpRXFjd3ZINnNDZUoxVFI5U2FkZ084?=
 =?utf-8?B?YVZTY2dubmdCQ0dXcVZRQUVwTFRDKzFBdjdldlkyeElmdkdkVFBQaGR0UUtV?=
 =?utf-8?B?SFUvNFFRWG01Wmh6b0JReTc1SVRPMklYdStQNG8rTThIby9QMkRtQkhQanpQ?=
 =?utf-8?B?bFV0dTdocTkyQ3BtWU5vN0lyQ1Rtb3RoVVVsNVVtd1JobTJEWnJqVjdBejYz?=
 =?utf-8?B?VXhwTGp2aEFoSjFVT0hQSldVaElsdG9Ma0E0WFNDU2R3R052d3dmazBOSktw?=
 =?utf-8?B?a1Npc3g5NnZzMGhOaWhkMGo3OExibG11RHF4YUVady9YcFRIZ1BNNDQxaFp2?=
 =?utf-8?B?Yzl1YzBFenh1bjJPVDlUR1cycG1MaEoyVHZhS2QreHdwNkdBTGlIMkFlWmhH?=
 =?utf-8?B?Q29TUitQRllob1BwK21KZmZPUVNiNXNjazdZSlcwVFFpekU5UnJSR0liUnZL?=
 =?utf-8?B?cWVuZVJhY2o3clBMUmdoRlNCVE11MURvQlVSWUkyUzhJcHk0TEZpK0UvaFpZ?=
 =?utf-8?B?ZHp1MytnNWVxQVNwbERscXU1SzA1eUV1d3ZLWjBQUFltb1B1OHVpZHNlNzJu?=
 =?utf-8?B?UTBBSTkvWGxaS05tQzA3MUlsd0tqM253bmhyOFo3bVFHaTdxZVcyaDRsWUNx?=
 =?utf-8?B?dDRhUFFHa3ROazUvRkVEc2F3dUo2dFZGa2MwOHNLUk1XaTZTMUVucHRNaC94?=
 =?utf-8?B?MTd1NmZJa1FML0RESnpIVGFJQXJObENWeTArUUhPWUpmejBVa01PdjBNOGlR?=
 =?utf-8?B?cW1iZFYxeGZ4RGY0cGl0WUhteUQzaUNqcGQ1cVNnbEoyc2V2QUdKSHY3T2FW?=
 =?utf-8?B?Qmthc0l3c2g1aHNPZ2lPWW5xNTU3Q2tkN1Q2RytKd085QklBaWtTek1zNHpS?=
 =?utf-8?B?M1JDaFdsM2toQ3hWTTlqeDVvMjk5eTNGa2MweHJIWVlJQkNqeVgvUjJ3R1Zi?=
 =?utf-8?B?SS9xbENLeUZydUg0SXI3MERXK0lxQU1pYkVBSFFvemwvMmtqdGJjTDNMVGVY?=
 =?utf-8?B?eGtRbGMvZjd3RkFybmtPWUNJZklCYWVTVzMxR1JlbjdNVk9takVSMHIyNmhE?=
 =?utf-8?B?VHMxOFNhUHVrKzAvS0dFVDJsYjRON2FtOEFnTVVLckdLQU9aY252MUlVdGJz?=
 =?utf-8?B?eFNZMlB5Vmc4dk9hS2RpSVo1NHdzMnMrR0ZsTzV0VlIyTnhWbnZ2L3VvRDg4?=
 =?utf-8?B?TWQ0MWlKakFRa2s5NHdmL2xURlQvcU4vbFVnOVdDVldheDZ4cllNQkV3dUxB?=
 =?utf-8?B?K0hTRzRuN0JJU29BZXNvVUloVjNKbk5EWGhsN0piK1BQK09BZlZBZG1zQ2c5?=
 =?utf-8?B?cU1Hak92azZWOE9Gdks4emg1dExNRTlTcE1qS05zMk5VWEUxVENyYU5BOXhS?=
 =?utf-8?B?TXVvZ0dDK3V5RmEvTHRiMWhUZkdoRHhrSHFnbU1qOEllVnUwNWVUbkFzait0?=
 =?utf-8?B?cWpFY2ZNZG1qbG5FV1B6dW85c3dJMnhwMk91NFlQYUZOSnpmRXpDWVZjR2FG?=
 =?utf-8?B?R2s0YmVNQ3oxTVAzWFZlNkJiVCtUd2tYQlhSeTlDcklHVHRlMVJpSDZGSTZF?=
 =?utf-8?B?VXBSOHZiTHRJK1JKdzh4QW5hR1NybHk2ZUZxS3Y2a2NlaEx6MnhIUytPdmlx?=
 =?utf-8?B?cW9Va2ZhajBGa2w5TVlCUUJTaE1yUmpJMWVPZFBEWmpoTnZHdWwyYmdyL0VJ?=
 =?utf-8?B?eHlLbmx1cm4zbi9Cc0p0ZEVranlXdTYybjJUOXZhMUQ0dDhSK0pXMk5ZUFMr?=
 =?utf-8?B?STlNTG9qdE45b3RGd014ZjJiSzBXbGh3SXJxUUZmOVQ0NGtFZ1VLOTgyTGVp?=
 =?utf-8?B?c0xic1dkVklNbVc3bmVrd05MU3RtN1R4dTZueUtpKyttbmxPa0lBMDJFRFVi?=
 =?utf-8?B?NzdHN2ExSW15OFg1eG53WHZOTnhYTXJFbTFUWm9IYVZOcVF4ajRNTnQ5Rk1h?=
 =?utf-8?B?djNBc1dHUW5hQWluaXAyNGxvcDNSL2M1NHFRRnFGUzVPOXFzdWI4M0VKcVVS?=
 =?utf-8?B?dHhRa2ZrY2pTd0pGaGU1aWNxVk5jMC9CSE9id1E2d3BFSks4K2RXVXJ5aXF0?=
 =?utf-8?B?ZnNPL3hWYUdzM2ZPQUJDN0M4TVN3MkRJa0FHRGhxMnVXc25mR0dMbHVCMmpN?=
 =?utf-8?B?Ykw4d3B3Wk9obkRVZmt6OElWRG55YVdUbUZQdnlRVjh1ZkZDY2ttQXFONEN4?=
 =?utf-8?B?b2NzbWpQWUk1b1daQ0YvSjcyeVRBK3FaYlR6ZjZzYXhVLzdNSzJDL3FoMnFE?=
 =?utf-8?B?M0h1eFdTZE9SOWxyeUZjQjF6ajVhc2cwaE5ENVFOMXR5MGtqMzR5UFp2cVRG?=
 =?utf-8?B?dUtHWjBORHZDOHozRDVGV0V0UnIySXZBYTN3bHh4b3JuUDNTbHh5dz09?=
X-Exchange-RoutingPolicyChecked: VlxlRCf5FkMHJ5+iIgaQTsqL6OUaHYhFxRKZhzvyuUx42kkqsoavgM5+4ywVt5R94OcK9YHfKYss1pUXqlPhWsSsYWmst4YCvGqJl+0GscH61V6j8YSwzQZIYiwAm3Wk3E1Dq2pxoyH0xO7o3MkbAHyFSj0e+i+X1m9ObB+x659LFpwy8UJngN6gP6ZkFX6w4jO+1yL92aU3oPbG08plZdLHq21wllK0ZCCYEmsGXcqiDs7rffLZqEy44UkGYMZ/ag0K6+8zKgvaimCzFc5kQ4/coykTAeYlCOlVBZiirsDMEEgEMn8DTRxSrSDxv7fLhsUHD+U6WlE62EdzobWXsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b5ae2a-a972-42dd-291c-08df1dc8fefd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:28:42.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb2AduaX2FAHQwqaFQhHejLiBp8RQPV15GHMYbscHb+LZtm1dpXCFj/ovuBvnZSWF3cxF1XA5GK/jluEe+v6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5145
X-OriginatorOrg: intel.com

Hi Peter,

Great comments!

On 9/25/26 7:18 AM, Peter Xu wrote:
> On Wed, Sep 23, 2026 at 09:27:52PM -0700, Kishen Maloor wrote:
> ...
> Yes, I think you're right, the ABI isn't the major issue. If from KVM's
> perspective it's always convertable between GPA <-> slots, then it's the
> same.

Correct. It's just that when the bytes aren't in any memslot there's no way
to reach pc.ram's HVA on the destination in KVM's view to write to it.

> I believe my mindset when replying was pretty much in QEMU's perspective,
> where in qemu we can have two ramblocks plugged into the same GPA range,
> only one of them will be visible to KVM and guest (e.g. which one has
> higher MemoryRegion priority, but it's not the only factor). What migration

I understand, and it matches what I found.

> module does right now is, it allows both ramblocks to be migrated with no
> issue, even if one is not visible, but if it used to be touched, since that
> ramblock will maintain its own dirty bitmap (GET_DIRTY_LOG on that kvm
> memslot when it was visible to KVM, or maybe set within QEMU userspace
> somehow).

Correct, and regular VM migration bypasses any notion of GPAs/memslots
entirely. It migrates RAMBlocks by block+offset. QEMU sets every RAMBlock's
migration bitmap to all ones before the first pass, so everything is
transferred in round 1 regardless of dirty state.

> IOW, what QEMU could do here is, after MEMORY.EXPORT, convert the GPA
> address space into ramblock ranges in QEMU, migrate with that not GPA.  In
> case of PAM, it's part of pc.ram.  Dest QEMU sees it is pc.ram, it should
> "apply" those data to pc.ram ramblock only.
> 
> For non-CoCo, it's as easy as writting to some host HVA pointer.

I understand that this is how it works for regular VMs as the
destination is able to memcpy into the HVA obtained using the block+offset it 
receives over the stream.

Also, when migration is kicked off after the source has fully booted, the
PAM window already maps to the source's pc.ram area, so the export transfers
the right bytes. The gap is purely on the destination because its layout is 
still in the boot-time configuration until device state lands.

> Now, the question is, the new migration API only allows applying data in
> GPA ranges.  I don't think with TDX there's a way to "apply" the data..
> dest QEMU just booted, this specific portion of pc.ram may not be mapped at
> that GPA source fetched due to reset status of PAM registers.

Correct. In TDX, the page is placed by the import SEAMCALL at the GPA it was
exported from. So QEMU has to turn the block+offset back into a GPA, and that
GPA has to be covered by a memslot for KVM to resolve it, which it is unable to
do at that point.

> That (rather than the ABI interface), might be the real thing I wanted to
> point out.

Understood. I did also wonder whether other VMMs organize their guest memory
hierarchy in similar ways.

> Maybe it means TDX just can't work with it by definition?  I think it'll be
> fine, and now I wonder if it means PAM will be working for TDX only if PAM
> boots too early so it was before TDX initializes, then after TDX enabled
> anything like PAM will not work anymore?

Upstream QEMU gates the separate pc.rom allocation on !is_tdx_vm(), so there's
no second allocation to flip to. I don't see any other TDX gating around this,
so I presume that PAM operates as usual otherwise.
It doesn't appear to be a question of PAM coming up before TDX initializes.

> So it seems TDX will "lock" the memory footprint in place when enabled,
> allow accept/unaccept (or say, plug / unplug) memories, but anything like
> "flipping this to that" will not work.

Yes, I think so. The TDX module holds the GPA->page binding, so any change has
to pass through it. Adding and removing pages plumb through the module.
But a sort of content preserving remap of GPAs in the way QEMU does for PAM
is not possible AFAIU.

> Then there's a very corner case question I want to double check, and I
> apologize if this is stupid only due to my ignorance on TDX knowledge: can
> someone migrate a VM too early so TDX is just hasn't been enabled at all?

Not a stupid question at all. I've actually tried this. TDX VMs appear to
migrate fine beyond a certain point mid-boot of the source. Kicking off 
migration any earlier causes the destination not to resume, even though the 
migration itself reports success. I haven't yet confirmed what that point is
to explain it.

For now we're trying to settle on sound fundamentals for the UAPI and flow,
but this is definitely an area to dig further into.

>>> I'm a bit surprised that TDX will also monitor how many times the same GPA
>>> is updated per iteration.  What if below happens:
>>
>> Yes, and maybe that is because it won't know the ordering if the same
>> GPA were caught at different times in the same epoch and fed to different
>> migration streams (which one is newer?)
>> On regular VMs, I believe QEMU doesn't migrate the same GPA twice in one round.
>> As I understand it, a migrated GPA is revisited only in the next round.
>> I suppose TDX just makes that behavior architectural.
>>
>>>   ...
>>>   ITERATION sync n
>>>   GET_DIRTY_LOG, see page P dirty
>>>   migrate page P
>>>   GET_DIRTY_LOG, see page P dirty again
>>>   migrate page P again   <--------------------- [a]
>>
>> QEMU shouldn't transfer P again in the same round, right?
> 
> I believe yes with current QEMU, I can't think of anything otherwise.  But
> still, this is very specific impl detail.  There's definitely no issue
> migrating one page twice or more in non-CoCo.

Thanks for confirming this. But do you think it would be a problem during
pre-copy with multifd on regular VM migration if we didn't have this
"transfer once per round" logic?  If the same page got fed to different
multifd queues, couldn't the older copy land after the newer one at the
destination? [1]

With a single channel it shouldn't matter, but it could with multiple
channels. I think since the bitmap sweep is shared with multifd, QEMU ends up 
transferring a page only once per round either way.

At least this was the rationale I conceived in trying to explain the TDX
policy of not allowing multiple imports of the same page in one epoch.
Though the underlying concern may not be TDX-specific.

> I can give one example to illustrate what could happen.
> 
> In postcopy, we support preemption mode, which is simply a separate fast
> path for requested / urgent pages.  It's possible while background thread
> transferring one page, the fast path saw a request on this same page.  The
> current algorithm is simple, it will wait for that in progress background
> send to complete.
> 
> But logically, we could do it the other way too: send the page again on
> fast path, in postcopy the page content is guaranteed to be identical and
> unchnaged, it means the fast path can land this page earlier, reducing
> fault latency.  If so, a minimum cap we need is MEMORY.EXPORT be able to be
> done twice, so the fast path can read the 2nd time.  IMPORT is more

We shall check about this. TDH.EXPORT.MEM (the export-side SEAMCALL on the
source) may already permit a 2nd export of the same page during post-copy.
If it doesn't, there's a good case for asking for it, since it would give
both the background and preemption threads a shot at fulfilling a request
ASAP. The import side might still reject it, so your suggestion below looks
like the right place to handle that.

> flexible, because QEMU can maintain what has been applied, so logically
> background loader should be able to skip the 2nd IMPORT.

This would make sense to do I suppose, because accepting a 2nd IMPORT would
clobber a page that the destination previously received and has itself
modified.

> That is not a good example, at least because it's postcopy and doesn't
> happen with precopy. So far, I also don't think a major risk, but I confess
> I don't understand why TDX needs to add hard requirement on "only sample
> one page once per iteration": even if VMM sampled a page twice, it's still
> encrypted and confidential.  I believe it has something to do with the
> whole attestation logic.  I think it'll be more flexible with less
> restrictions, but no issue I see either, hence please only treat that a
> verbose FYI.

I think the transfer once per iteration might have everything to do with
reason [1] I mentioned above. I've generally noticed that the TDX migration
architecture reflects established practices of VMMs. That being said, we
should look for instances where a restriction deviates and poses a problem.

> 
>>
>>>   ITERATION sync n+1
>>>   ...
>>>
>>> Would above crash on destination TDX at step [a] applying P 2nd time?  Or
>>
>> If P were migrated again, then I believe it would fail to import on the
>> destination, and also abort the import session, so migration would fail.
> 
> I wonder if we can just fail the 2nd IMPORT without abort the whole
> process, then if userapp wants to detect it there's a way to (similar to an
> -EEXIST).  Not a request, more like a pure question.

Understood.  I think it's TDX's way of assuring correctness in case a VMM
transfers a page more than once in a round. QEMU doesn't. In theory it
could relax that when only one migration stream is registered as the
ordering would be unambiguous there, so a second import is provably newer
and could just be accepted.
