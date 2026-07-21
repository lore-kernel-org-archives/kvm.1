Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18327E1DC;
	Tue, 21 Jul 2026 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632293; cv=fail; b=kiNqxrWdH0vI1KzKfTDDRM1WQfZ5yXiOdnmIXfqKJTYHsFkSzWz1AxamNuoBsWLlK8goVqfhMl19cV8kOGDVOvQq8cOpZXqEsNeBZIyNUn/gfLHJdqGMK8I4HWutoh9fSk2mN6w5aWnz8v4wL3V1edOcvB52FivDw1e82z1z+7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632293; c=relaxed/simple;
	bh=t5WhFjR+VMDzZGtYfUQ49gcOU95jFzPGnCR5sl+iGlw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qqu2hKqcB5uf/mda293movYr6f1FiqYn1LFWTxd4N5WL0+SJQ31VVGGYtKhlAHMprcEIGkh6hSg0jvMCiTnigNgI67GeSLVP/b0SrJObGnrBc8cDAohwzXzRLW5y4yFmzb41BPED6h1xhPdHKSCb/OBCke52LB6YUu6Wm/T/Z7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTQpnORw; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTQpnORw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784632291; x=1816168291;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=t5WhFjR+VMDzZGtYfUQ49gcOU95jFzPGnCR5sl+iGlw=;
  b=NTQpnORwDBkdAsfA4fCDCdvuAXIWej8rDBRhchGzwzRF1vpKqrGEG6v9
   esEZTqtSxcAk7VsvudtAqaY7LqcKlILRjYalxC0R1BHIMdpEh4ZiCU4lh
   O8t929bIsNLLABZFPCwfUWvZ8S0dVPl7d4nURYfcRh9tWdzL56hgQrQmK
   /reAmNL2zHLl/T0RbuumkDn03zf9gQQBWdd71lISlwx3ewYqACNBzPX4X
   02m6aRwAWeREBatcPplSlIYrgPOVcWPFHinvqiI9gvO+83zMa/T4Zie9f
   S/pWuNd1UStpUxMyt8+N3Z9mubPrcZKBQnY6Z5+d1/6fdtwBtENRP3kGk
   w==;
X-CSE-ConnectionGUID: OQbBLw+uTHSRfoz4b0BUmQ==
X-CSE-MsgGUID: wPWlg1YETZ+4Hh8k121vDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="108017977"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="108017977"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:11:30 -0700
X-CSE-ConnectionGUID: RVuj5la3R+miQITyacwPWg==
X-CSE-MsgGUID: 9X7FZ8smTv28yDgNZVJHBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="256530158"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:11:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:11:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 04:11:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc7T32tYoGrIjK/SJHDavF91PPexTsvrVZQlUgvTx07O23Vxv0/3UI54cRQ7OdGZMewwQ7gSCdsQw4evxQ8Dev7wD7V6I8NJsCDxSzD3FKpk6W1SDiEU0twfz6FtUiaogLsLZAQzjBid5XEflut2OshTElUGGcwwSLUAwRHyaaIKNFeiF/pV8SCRigz6+N3E9JPVCQxDj2luXlguCioh6FVI5b5yflShuZVU5rmzxjskFh6WGI870CKI7L9EZ/cMaKaGsFvQmbYvZRTY0MdxKQJdIaSMIAhvSpW2uOa814OZBWLeD4s2FIdIvQwhGUIRVPIWse8a1/RijH/gtJE0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jnQCN/NEwOqr0bdmt0JbLSN6pH7pS3jqDxPUD6q4kA=;
 b=cfoj5zSIuBChvMXPFTYyqMe+tXtC8L1ui7ql9w/swgMzGgY/0Owx59oOv15PoV7n25KRryEHlpIg9dYPgWOqsVNKfQt3AP++Z0pFYueXpgYjiDY5QCVOlV8vcuhOfwBDjHR/AcAhIg3A/N/QBCf6crqExWxvUophrYgHr9EI9zN8BpglHnZWis/CceTg9kBdglFG8rzrpFrnKSfnmRWHtoY2d0nK0voPuqCpktefxq8oJKsPkvRquK06fD5+Nw+i/nZ4oqJO6YUjEgCNBRTBUsd+Mtcj+Hinpg5bN6k1jZmc9551WX2wCI0qTufiVS/AJhLm/E9ksHPqv7e9DJNVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4450.namprd11.prod.outlook.com (2603:10b6:a03:1be::20)
 by PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 11:11:27 +0000
Received: from BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068]) by BY5PR11MB4450.namprd11.prod.outlook.com
 ([fe80::741:ee9:97f1:e068%6]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 11:11:27 +0000
Date: Tue, 21 Jul 2026 19:11:16 +0800
From: Chao Gao <chao.gao@intel.com>
To: Jim Mattson <jmattson@google.com>
CC: Sean Christopherson <seanjc@google.com>, Reinette Chatre
	<reinette.chatre@intel.com>, <isaku.yamahata@intel.com>,
	<pbonzini@redhat.com>, <erdemaktas@google.com>, <vkuznets@redhat.com>,
	<vannapurve@google.com>, <mlevitsk@redhat.com>, <xiaoyao.li@intel.com>,
	<rick.p.edgecombe@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenyi.qiang@intel.com>, Yosry Ahmed
	<yosry@kernel.org>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
Message-ID: <al9T1Nuc74W85sJl@intel.com>
References: <aga+jCVUW0d4GufQ@intel.com>
 <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com>
 <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com>
 <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
 <aiJlAhqnU0lwOAcG@intel.com>
 <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
 <al3ygBbMHq2ltdYN@intel.com>
 <CALMp9eRpgpgbG+FH_+zGrgeDX_en9jKogZ9=BBHMKRY+_cz9rQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRpgpgbG+FH_+zGrgeDX_en9jKogZ9=BBHMKRY+_cz9rQ@mail.gmail.com>
X-ClientProxiedBy: TPYP295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::18) To BY5PR11MB4450.namprd11.prod.outlook.com
 (2603:10b6:a03:1be::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4450:EE_|PH0PR11MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: a52f846c-f664-40da-6599-08dee718ce29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s5gBtrKGOH/dLOzj6m4T8Nvjw2Gw3FUQ/riWSeILHZG9QjgRmBNFaTkFWGiIbGF7p/HqSUZJZXebLfO6ZFhdh0d8fGUxV31UkuajtexOb6hVTFatT+M0wZ5oVeV5pKmD9fvQwPa+EyoBktD58cN3F5iL5g/nW091hdT44UcbeC9fovoxZpQi6Fa1k77kbpIhNjVsJ/gXQxVRTSDBdcCYmzGYNhVLnh1/icBnStc8gopnRNyGc6/EIzq7BxOjHaJ4FcYG76G4dO8HAcQ+WTo1CpbRtOy9WLqraY1Gjm29i6QP+w+9WkAWLJsaqRruHVYEA4ldk0xtRr3cjXNFCjV7PyOeVNrO4vFl0hWPPB+QGHENRZX8eKr/E5EiYP3TZR33Jse1b/rHwAgvIrVwE1U7vwYoiZkMS+fcI/NYn8cHw/n8gEmYXf4C/ejfMzz2fx0SFVrGeJIhm69gUi7tD+kr2Pfe2Q9mMEAX+m5HQbqjQuXu2nK2P6/9mYvRleDdSUzLOY+ynp0LaciDUuzI4RQ+tO4HrKYYPRm7+gfHnER+3DH3mhxbd9ngbL1cvrjKgmui1xpfH7NzOawuVSayu9K6eJak+V7LO+uWILa5PGbkF5YgMGP156w39O3UBeEDQmyrgZxWr84UkY40MOVmBK233FYThMFdHx9s3LgJuFJy6YY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhDUG5jcFJOSDNXS1lIRnpCK0R0Vy9pWUozaXpZN2VzWFUxNEhlRWRwN0h2?=
 =?utf-8?B?MnNnejlteksvVTg0ZUVwMzVKSXlFdlB2dmlqb2pvaWZYcDdPUW54eFRpVGRY?=
 =?utf-8?B?dnJHaW9xa2Z5YWJLQ2dlMWJpci9KQXlvNlBoa2c1cTFoV3hrUGsvUmw5N3ky?=
 =?utf-8?B?LzVaMW1FKzk2NENrcUVDaVhqZUZQdkwyVXdTbWRGdWNjRWJ2Ump5amlDV0M1?=
 =?utf-8?B?RmIwMXdQZkhTYjR0UEVNV2VFakhuUVlWRWZRQnd4SG5jQldHdFZlQUNIK0tZ?=
 =?utf-8?B?RE51SlJYMC9SOTl2WWdDSDNBaHk3NDB0K0FDczArQVdweEp0bmpyR003RGxt?=
 =?utf-8?B?bm9ETGNEdHQ2bjRRWHhUeEN3R0tSR0FmV1VHbVJPNWF4ZUtGNnhGQ2dFRjhY?=
 =?utf-8?B?d3ozYnQ0U2NhWm1GRDlpTTFWMFZGUVR3TWtCbk1JMldNS0lyN1VXRDc3d1JC?=
 =?utf-8?B?NEtsdXZGa1BlaUh4NDMvNlN0OUtEOHVzQnFreDFBNXRVdk1ka0FpQzRCQXQy?=
 =?utf-8?B?OTJuTWxYRWNuUDgwb1VwTTFkT2hPZGo0Vkdud1NlcUptNW1hYmZQS2M5YTlV?=
 =?utf-8?B?bFhucWZzWDRKSUdVWlBycDJ0ci96N0hQVXp2TkNiTUdJcTJ0bWxtcWVOY3c4?=
 =?utf-8?B?Mjc0N1VQWm1TeU8vRTFsTm1EKzF0Unl5UndHL1IyWGtOckZtZCt1UitTbno3?=
 =?utf-8?B?dmNmR0VoTzdLcUJydDdxUmRaSUJjK3RwbTlEd0JWVTRGTW5zTnBJVVRFREVV?=
 =?utf-8?B?Wm9UaXhCT1FpcHhyVWs0aWhocHJVbTdQVmVkaE5Ea2sxSVlFUEZIdVI3alps?=
 =?utf-8?B?RmJvSnJPN3JidEZQSGk1NWVTQ1ZBczhDZWVUUUlQd2lHNXNjYVY4dXBHMG5U?=
 =?utf-8?B?NHgvM1FPeXFSK2FqelB3ZGpMbVdjaC9aUUp6RUY2bXJJWEpXWnRaZzdjekhk?=
 =?utf-8?B?SmdicDk5RkxSaTNXVmhLRnFRMzFnYUozMmRENkFtZVhNajBvOUFZbTI3all6?=
 =?utf-8?B?dHZCV3N1bHpnNS9vdDMvaEtFVXNhZHJqcFJzUmVFRTU0ZEtJdVNtVyt2NnNn?=
 =?utf-8?B?dHdnU0RyM1BUQ0I2b3J0UHlscnJKbmVnTG1WY1pFOFhTUkhKT2krOVFGWFMx?=
 =?utf-8?B?V2VKZzZqSTlLSVhoYjh3Q1hEQXRaOGI4R1FjVDJCb0NXREsvb1FTS2VMYklR?=
 =?utf-8?B?emErRWRYSkYvOVpEWTRpaVVvTUFqaE5KRWVpNnB5a0tXOFhSaGlhd1dmNVFW?=
 =?utf-8?B?Tld1OWFEVUtLMnF6dVFLL1FpVEZ2eGtOOUZyakNHS056bUhkWjlsUnlka1FU?=
 =?utf-8?B?R3lqRVlMOXNFdWltb0ExN1A0eWYzSHVjRjAveTZYOUNxSkJCb1IzN08wTlJ4?=
 =?utf-8?B?RVduOGFENzBzeXlRYXVPczVQN3BPTTJuYzlJY0JyaXFNeVNRSE1QY1BwU3dn?=
 =?utf-8?B?enpsSEwrMXM0Ly96dm5tbks5ZFFmcXI4dk1hUndROHAzenVEZTlHLzRtcHY1?=
 =?utf-8?B?U1FwYWoxaUtDY2RkZlRzSFh6anhZaEV2WHRwdU13Sld0ZER4bU4wbEtoQkpG?=
 =?utf-8?B?SWZXUHE4aWVTWk9NNnBkNHNWMXhuVWo4SHhhUFdORjVOYmJOTmxqbG5Gd1RI?=
 =?utf-8?B?SG9mUjRrRDZ3RzlKZi9uazR3Q2daUVhENGRVSlYrQVpkTmpnckRmZElWeVUz?=
 =?utf-8?B?VG5JMDMzZUdxVGhXUlAxZWJ4dzRtWGZUaDJyZVdEai85c1lvQS9zY28vNFBD?=
 =?utf-8?B?Umtva1FlMEZOdDFheUU2TXdzSDBLZ2F6Vms3S0djbWQ4R3J6czZzTzhaUHRa?=
 =?utf-8?B?NjFVZFBKMTM2OWFhOUhiUjg5bWM5cTlQczNVWmp6NzdGQVRhT0tXbHpZeTky?=
 =?utf-8?B?RytRODBHeDA3Yklqa0pnSXNveEFVMVVlM0ovTEIwb1VtbjhLeDVqZnVzNmVv?=
 =?utf-8?B?NTFWYXBxZ2oxUm1Ka2kzQmVLWEtXLy9VektjVkZmL3I0OEZTZU9WVkhJeUJW?=
 =?utf-8?B?MVNzckRneHdtMWNPclNFdXVscUEvUERUWjZFZjBDZW5iMFZLS1daSjd1VEln?=
 =?utf-8?B?STJCUHBHenlmT0FyaEhFSU9qbFV2eFlxY1RKUHVUL0J2NDB0ZUhsUkM1WWt2?=
 =?utf-8?B?aGtyZEcwLzh5bnh6V0VHM2VSeERmWDNqdmJ0Zy9zWVdIUmdCbk56WVdYamRj?=
 =?utf-8?B?SUFIN0VLTTJoUjg2RUpqVGpLa3dmUTM0ZUlOa1BlUy9jeUFTL0tkcGdHdlBO?=
 =?utf-8?B?R1dLYW1kdC9NcW5SV3NzbW9LRDRiQ1diTUY2Wi9SeU9xNXcvWTlPb0ZYdW8v?=
 =?utf-8?B?MWFpK1Rwdlc1SDRPMHZJK0pwdzg1WmllZ25wSllMbEhJR3huNHVpQT09?=
X-Exchange-RoutingPolicyChecked: KnPXVaBR3fK4Xic9mr/u7U8HXF3DPUeDEsXlbixvTdyY4j8Ryy7JG08LUCOnqb1rxvnl4z6rARbXhDL5whba8VlCIKvZuqRCiKnfh2tir2l3iemHB/pPeyuyZxGLSd+4/NVntcRKhnnxRzf844bu/HUSkpN/pZTF96nv1/MpCESr6LLJBNv4A3LZ9Ek0kCOp050ODVKWJ7TSK7DN+sTHs41AjyIlaNKjg+ZwCs+pziBM5WS/AQ7eg9cQM2oO0M77J6iHQaqgfkGIHo7HjSRWU/dR0EsVDMuFVTTekgFugWcNEMdXBEseFhDEDx5ZDgzmpngg51hEOHgi7Q0peKGWmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a52f846c-f664-40da-6599-08dee718ce29
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:11:27.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgDl0sW0JIgb0+yFqwCZwWiXr4IqoCOJcnXfQivN88fFKqi5szOTWHpI9uAb41rlziRfYDPYB7X2EglvwqJrGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 10:35:46AM -0700, Jim Mattson wrote:
>On Mon, Jul 20, 2026 at 3:04 AM Chao Gao <chao.gao@intel.com> wrote:
>>
>> On Fri, Jun 12, 2026 at 03:51:56PM -0700, Jim Mattson wrote:
>> >On Thu, Jun 4, 2026 at 10:56 PM Chao Gao <chao.gao@intel.com> wrote:
>> >>
>> >> On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
>> >...
>> >> >With respect to EMR, you wrote previously, "A mitigation for this
>> >> >erratum is for software to program the VMX preemption timer for values
>> >> >below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
>> >> >
>> >> >My question is whether the exponent, 25, is a fixed value for all
>> >> >CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
>> >> >saying that the exponent may depend on IA32_VMX_MISC[4:0].
>> >>
>> >> Let me double-check this with the internal team and get back to you.
>> >
>> >Have you discovered anything?
>>
>> I just got the final answer:
>>
>> 2^25*M/N is the max value of VMX preemption timer for _all_ affected
>> processors.  Our expectation is that for processors that have different
>> value it will have the issue fixed (VMX preemption timer will implement
>> full 32-bit). Use of 2^25*M/N will still be fine.
>>
>> where M is CPUID.15H:EBX[31:0] and N is CPUID.15H:EAX[31:0].
>
>Great!
>
>How will software identify processors that have the issue fixed?

That isn't clear at the moment.
