Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF9381B0E;
	Mon, 23 Mar 2026 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774305696; cv=fail; b=UEZSxryB24XPGaT4Vh3DcnvrcjgDvUWX8fvM73FKq3eDAz7u8MqmTtrRIEi1Qf8xYgywQ6CeEElADMsUvRvc5TyUnsCtGxqw1pBH/TA7Oa9jq8uf3EOm1X7orfcCDEzbVYCBLo1cs9H7chyPj5zVJEIXuIlxKhtQUbVgSGBEeS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774305696; c=relaxed/simple;
	bh=wgxceY+/0oql/1GPGuPo2kAgr5QOrexn/n//8P8eWFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PURtLTSB+sDrxLjD30ls0CrpBIQOlOfU2/yM3gkMaUFehzHmEaGy9jxEB5HBAtlROuRjj5k3F0i+J2or+JZzeXycg4MzzPxKBYGA/Wvk+kmqLSrRAquc8V4otDY0uUkoJz/XXF+cE2iDCAv/82VzdcRiBnGgiFall2c6bZn9Ubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyRCkkos; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyRCkkos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774305695; x=1805841695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wgxceY+/0oql/1GPGuPo2kAgr5QOrexn/n//8P8eWFE=;
  b=eyRCkkos//5aRr6xqJGWln3lwsLdsf7pQLJ6GQB68trQ7ViNsUnkF1ao
   g4S3CH8sYUbjZLGYtf79YXgdFQiWneiupC4VdfW0FsQE6qsUD+u8ndu1a
   MHsGh9TSvhq7gMYYueGkgsJO9qTyGeOKoGkwP0kDQBS5dQb3WO1BraX1x
   MWjeydVroE1kSmVYcSP5aS8/va1Trq1ueWmf71QxKpM90+NjnPi0J/oX0
   ZqXJTxHvSogKKRrRVijPt2Hg6Y1uaN54eG9b5ed9F5WmKVZV0s4976ZWb
   GoNEPdpzNcHmgmilXxIeTUL6/DWIO0VlYY0+6VKVCfyOxzy9r6P0RJaq4
   w==;
X-CSE-ConnectionGUID: X9fXbn9BQwKfgYTpivZlsg==
X-CSE-MsgGUID: 5IdjbOlaTXyc6FlTCtPAZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86684798"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86684798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:41:35 -0700
X-CSE-ConnectionGUID: RpX5iGBqQO24mwn3m5zfEg==
X-CSE-MsgGUID: kT8My+MFSG6efhI6V3bV/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="262082026"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:41:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:41:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 15:41:33 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 15:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M15yZQEwsmKZztaOSZ/91WPme0eOH5riaiOkR1CTAjHwgyhIFdtNmSanxVFbbd18w+xNPANM/h2ulXfAkaDwi4zvdFSdRV5X+GemBntCLax9AYwCsPNtpUblNdvCGN4/qJX30aioSbREqyQmaMjV7/w97j49N6njVjf0fOP9t9O5r34+j6O8DbgmbIV7nwGp+rnNVCifSdbF/2c2/CFsGb9gqxB8oS+gX6x98JawX5B4+axWEc3uWg/AfK6hpsTzD9aQqxWqOiGkdTxWcNEpqm2cApaIhZpDk0qYbLjKqBCZVXeQw8TlViuBPrLzV4piNop6QrsMXmzBP6JvQ5MUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgxceY+/0oql/1GPGuPo2kAgr5QOrexn/n//8P8eWFE=;
 b=Q39C7SogOZNPhN0PlyKJ1VHH2koZAka2/HKQD6hxpAptYKXdNZv6MJtoSBFTH1JpOyXsejEwBGyMHI7aW2sjBFLEgaAXU7o8Lf5PcuFTCNIh22Cz+vMQBb5GQaIq4EZKJz5tVOfrVTtwKZ9Bll5pmMXiXBU9pF8GKbz4LOacb8eZSZXdq2S6XjA1iGFFzGekDAT9//82122igRPxhoRBZ2LMKcPXxFkTCzkgAFN5YZdsZkN2kPJQP1et0bCup3zvVSK0b03iehCiJmG3WAXyJ/eyXSo93hf1t0OrJRiJik6TPVzJ742JrjhC61IJA5rO9f/RFMn/io7IzNEdHT0nOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 23 Mar
 2026 22:41:31 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 22:41:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "Verma, Vishal L"
	<vishal.l.verma@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] x86/virt/tdx: Remove kexec docs
Thread-Topic: [PATCH v2 5/5] x86/virt/tdx: Remove kexec docs
Thread-Index: AQHcuwg06jtL7quzH0yl9UiY6bfNQLW8tk8A
Date: Mon, 23 Mar 2026 22:41:31 +0000
Message-ID: <05a361443a6af50934d26ba51026e1447182f987.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-5-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-5-87a36409e051@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ5PPF3A51834D3:EE_
x-ms-office365-filtering-correlation-id: 2d08e265-7758-4171-4137-08de892d5417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 2x40FDUEy523f0mS0Uf3/g2xpTrVnWPUJSKAs7CvIw4PAhLZTtEZ1InZyWyi9Q63bG3mHQ8HKCKDyUY7FR4OgPsw0kJBdzbi5Zft9hPhu575QpUvKEhyGxCnckZX3SzBBZrFmc2dJqreaO6r4FZURMNkCvAGDQbI+ClyG/rpel0WcMYG6CvG0Sx3sC+hyUr0DyK0gCANBxxYLZJyuMSI14FfMbSnq9bXkmbkXjNY3XyhlTU+gC7pltjh//JmwuzUgWV3YsoxIbb2r80istRHVFMxjEePFVA+e6tewhngfqvVvNzFVIrgwyl2fJXn1C/U8PfcWTnbwVP8e/EcJWX7SL/qF38iFdliK6yrXytIBv6N7IsqGLvhhsj/1OYbZ07GxZGeVMeXcRqcOGbxSqcNeUC3TAX8DbI3EGYb9NsUO95GsNEz0E6c6YSIFZ3Zf7h6/PBeSaU0i66y1otzLKXmnGSIAvBMa4n/TUnSk1zuxUTiks+OmBCII1Oo5yPU7b1yF68aHAs9pHACKaXcx/YNS0XxvruKMcF7d7RQZRhvgCvEu/jMGP2M9b40TAcbSqzCDR7mwg2QTaJsdBv2Wv9HFxf44iB9YPZeJoZcChhE5ooMy14t43Ii4ktqcdsOuOaGC7TNNKoHQPblXxYsF6RXkJ7h2u2qNryZT07Ib+dFe7Nv+7bgNmY5GzxEtCLPwL0V4S/57vYHi+cfyLHHHFQE0Gp2/pN0z44Wac3MBZiPC8l4dBkeHObmSIJmYMbL3ztaGWY8WI5LMWdvjKd7KFo03BHYolLkxQrGmB/p2hXtbradiw2FemmG6jyh58soMX+r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHMwbE95dUY4UzhDVktRVlZCNmpQaDFCMmhpOGhFSHB2RWJGZDhJU0R6T0t6?=
 =?utf-8?B?aFBLWTZiVGd5L2E5NkpXem1lamRoZVg4akpjcWlpQUhaVmNNVk56cGd0NXRi?=
 =?utf-8?B?dk9YU25ESGJlc3NmVlhJRjlWeUQ2SkZicWxhQ09UMXZScDF6ZE9XMlJ0V05E?=
 =?utf-8?B?SnlYaVhyRkhQblBibVQ5M2MzTVdrN3pUZHdYejBmMWgwOU1pNjhKU001dzEw?=
 =?utf-8?B?K0sxUXh4OUR5YTZXRi8yYlJYYnF2UE9pK1kvSXRPRTZkMlhEY0Fsam14RlRY?=
 =?utf-8?B?am5PL3lmS2RwLzgyZkJSdmVmRm9yekxVVGlKTVZ3MHlUeUNza2ZMTkkzNC9K?=
 =?utf-8?B?NXNJVW1hT1R0dHV1MnBzYk5zUG5aZTVFQVRCMW1GazFvcDFqaHpsVTZnSGdB?=
 =?utf-8?B?OEd1cGJEZVcxb0JPcU1UVmxuSG1pN3IwSWN6SUhPRHRnTjVFNUx3MEhweERv?=
 =?utf-8?B?WlRvUzcvZzVHQmw0YUpvME5uclJtSVc0ZHNTRlBEeXZtTzdWbUZVZmoyZU5s?=
 =?utf-8?B?c3I0c2pvR1dvNFhBMTFDZEYwcVZTR0dWRWdsZ3pHTW9jZURzVTlmaE5rMlNp?=
 =?utf-8?B?VlFlUFFQdUx0TzRrTnVVeE1ENmM0R2VOR2tuaWd2Nzd5Q010bWQvWHNpTnFL?=
 =?utf-8?B?b3dqeDNSenh4cncwbXBKc2FPWVE2TTB5Z1FZUXhRbjVIblhaWHhFQTk3b0Fh?=
 =?utf-8?B?ZWZpR2RhZW10ZVd2SjBEM3NGeWJLUTBRQ21NTDhZTXFQcm9qSnE4bWh6RjJy?=
 =?utf-8?B?Wks0MEJEQnBzakN5YkNmN3g1VWJHWWk1TG1JbUpOTjgwQVM1dmlaeEhxZ3VV?=
 =?utf-8?B?Mnkzdmd5WUtyVjlFU3hyTmNuaEFQdUthdUMwVmNEVGtjTXpoWEZicEdlM3lY?=
 =?utf-8?B?R2g1blpNczZXVy9jL05KOHIydUxLUS9JTnlINXBhZ1VXaEUwM2pIZk00d1VK?=
 =?utf-8?B?azRjdFBoWUpCZjNtRWFlU2U1bE42akNReE5CVHZnTG04d3FmakZWek9weUV5?=
 =?utf-8?B?bmRkRUlHa0FkbjVWWFVnWVJybmIrZmwwbVNTaHhQZ1ZxOFgwMDRMZW9iS1pr?=
 =?utf-8?B?amQ4bXF0c3MwQ3VjNUJYbTdLTWMvM1hJYldKWmRwWUNVODFYSGJ5MS8yZjVp?=
 =?utf-8?B?ZnJoa0FjLzNkRDY0dkZoMFBMeStnU0ROMEJ6ZnhwaGhKMVdtWncrNmcyK3cr?=
 =?utf-8?B?bk50OUFFQ1RPYm5Uem5NZ3pXKzl3K3Z5QUgxOElZdDV1cVB4aEJTRTRWR0dU?=
 =?utf-8?B?NFYzTENjRzVRcGIzTXRnVm8rbTEvMnRsemtHOXZtaVBFK0k1MHFvT3k1NFZ5?=
 =?utf-8?B?OURLOU1QalA3TGgrZk95RmdxN1FQWmhUSXlTQzN2YlVBVGY4OS92eEdLWTdj?=
 =?utf-8?B?WHpDamQ5SUxaajVRd2JLekE4MFdqeW11ODRaVDJrV0x2dDR5QmtaOEpiQTlF?=
 =?utf-8?B?VHluWS91OGhlSGo0UW84Q2FBS1F4NjdjQkNJK0F0OGtWQ2xOc3dCd0F3OStD?=
 =?utf-8?B?bDBSOEFGWFN3d0FxampNMk8yYUJKL0F2dFo4ejdlU0RWa0Z1YTMyTG1CWnBS?=
 =?utf-8?B?QkVRN3NvaU8vYU1UbThPTG5XYzRycU1ITWFCVVh0WndWRzhUK0wybG5zVFZz?=
 =?utf-8?B?ZTJhS3F1WG1WNkZ4NEhPRFhrcVJ1US92eUE5VkFnZEtHZzlITFlmd3IrVXF1?=
 =?utf-8?B?b3FIdlVTSXRYZC9sK05vSFlNN0RrNEtTOHhWMHJWOGlKejB0TTZUSjlHbVZN?=
 =?utf-8?B?SzE0V0VGT21NK3IvU2ovQStucVZTK3NTMG55YXJ1enJQcUJtUG16Vyt4VWZy?=
 =?utf-8?B?V1FBcGVsNWtjY1FRWlFEcjZtM1RacnNBTzFPZ1NwVnlsL0pleGpyZjl6QjRQ?=
 =?utf-8?B?SHBiTUhrRm9PVC8wV0FGRVk0OGllV2h0THg0dDRmNTRlRFRNb2hhUEFsdVhw?=
 =?utf-8?B?RFRYZjNYUFNwR3lOQ0UzKzgxU043eFY3QzhIYXp6a1BPLzlJdjJLNU1KSXZk?=
 =?utf-8?B?em5XMVF0UEMzQUZ4OUxEQmM3cXAyWFlpcFdJQ2NPcUZuK0FEZUU0TVE3clBa?=
 =?utf-8?B?S0s5R0E0dEdNakZUT0o5ZzBIOXVuRHFZTWI3RHQ3WFpERldFUEhpSXorVDZP?=
 =?utf-8?B?UzRTak4xdWZkaWZ2NUxrT1NHaW0xOWtxYW1wdHExYjhsaHFJbWl1YmVMcTdP?=
 =?utf-8?B?UURSa2hEb0dKR2krcWN5dnprd1VtZjZIUkYxSUZlU1JXejIrSko4YnhzZURL?=
 =?utf-8?B?eEppdTFERW1NWGxYc1ZmL0ozN3FZWFlML2x3TDFOUTVTK2MvcEhVWjdwT3NI?=
 =?utf-8?B?TkFRYVBEcllOUTVQN2hhcDdsNHhXclZxdnBLUEtPbUxxM01wMUZvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5E566C271EB6047BEF918734C112659@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JEpMwsHgCKvWr7hIam1wti3To8hJXvKYECW7G2wVHdZyvzrzNQx1cbRRjQcRK7zPg1wgXE6JaPfi5w5cMBWZrMwBx6cUW2rK1WBRG4uOlP3UrtoPWHz1qPOViev7pmfoIDJNWe3boqcmzB7UDz7kadzVA6v2m1EWcbMLpPFR/WntI9nL58ySrTNxMPQhxckYhgRYvVkkvIaN4LKbZ5diXnWSM6qgcH81OyW8bDHqjDhQa7Gka+0hnUhRIwYkcaj5zsiX2XrA0WibOS2cglyFE/XpMoEdkHVsLp4b4XaW7XUzu2h7Tu7EIBt3VrBO+AQtr38mhbT712c8abGDY5hoGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d08e265-7758-4171-4137-08de892d5417
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 22:41:31.0346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90qXN/B3rkRnFoQX0Ho9ckvSCyQuWDwUaXHJzhik5G9r5JBV/g7UXaRaIjec2JCJEIEid9DRt6uLgA+D4mKfBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTIzIGF0IDE0OjU5IC0wNjAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+
IEZyb206IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gDQo+
IFJlY2VudCBjaGFuZ2VzIGhhdmUgcmVtb3ZlZCB0aGUgaGFyZCBsaW1pdGF0aW9ucyBmb3IgdXNp
bmcga2V4ZWMgYW5kDQo+IFREWCB0b2dldGhlci4gU28gcmVtb3ZlIHRoZSBzZWN0aW9uIGluIHRo
ZSBURFggZG9jcy4NCj4gDQo+IFVzZXJzIG9uIHBhcnRpYWwgd3JpdGUgZXJyYXR1bXMgd2lsbCBu
ZWVkIGFuIHVwZGF0ZWQgVERYIG1vZHVsZSB0bw0KPiBoYW5kbGUgdGhlIHJhcmUgZWRnZSBjYXNl
cy4gVGhlIGRvY3MgZG8gbm90IGN1cnJlbnRseSBwcm92aWRlIGFueQ0KPiBndWlkYW5jZSBvbiBy
ZWNvbW1lbmRlZCBURFggbW9kdWxlIHZlcnNpb25zLCBzbyBkb24ndCBrZWVwIGEgd2hvbGUNCj4g
c2VjdGlvbiBhcm91bmQgdG8gZG9jdW1lbnQgdGhpcyBpbnRlcmFjdGlvbi4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+
IA0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
