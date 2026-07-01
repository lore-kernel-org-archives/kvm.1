Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776BF224FA;
	Wed,  1 Jul 2026 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867927; cv=fail; b=rY7iFZ5GxskRCsn4D0cRICcUdh1BJNObcUD4+eyBvWb22sU7UtopqVxEwak5LWpzfWM1UGYSFr+8VrM0cGYFQUBfT2nnZkeD9/2+gir2OTNktGSiti8olln45p1/4oHhGUkuhcE58ka8PfanCuw90uOAjiXJYh8nkNTWHxl8clM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867927; c=relaxed/simple;
	bh=wYaKURdyw4Iu2i21HA4yxS9q10n8IpwlFd8ezTze2g8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KwsOsHscEjarUs5CKACPFrCkAib05A2zewDtdGZc3u6qcxmU5YegQoW8O6eNTL+zlFlOe4dThx0Cfj7MpnLLmFM+d1vH9QoiszBCmJd2rf6S7dxyxv5w9UF2WcOjmyqmq1x+k8JDx2mo8EybBXyv2FDbiZ9s6UGJg///nKVVBG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3RBaqwo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3RBaqwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782867925; x=1814403925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wYaKURdyw4Iu2i21HA4yxS9q10n8IpwlFd8ezTze2g8=;
  b=W3RBaqwol+zqNUh0YgFZhb8yp9NEZP65Tq1wFnE8DyXrN44rD24Ce2sV
   tj43hywEfGzlqlkWt/tlE0ChpWdJhZkDYzWDNMBKYHnDdF7L2WzkVZ9mO
   W+vCuWg4U/LV37/8505uQl5liq2onwgIcuzkxAUxDT7gUF6jU4l8kVpFP
   l7r6clxQvmLpQCIIxqiv8qIdYKddxNjaBNNHtMu+GgB1XaLV8alpNi8+z
   vg3dIm48CR6sbtbJ7yWdaiSIqrdkNR15KSXzz/Yr1fkZ7Ieu1kVKg05PG
   esk7NjRVZRs8wQdS2+K2cqpJqeVKHGqr18SbgGXgCWbqIjWa5yJrtLjSk
   g==;
X-CSE-ConnectionGUID: RoCELzvVSe6dnAQQL9wQEg==
X-CSE-MsgGUID: nRJneRQlQN6bfCTN4HKSng==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83464331"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83464331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:05:25 -0700
X-CSE-ConnectionGUID: Qn//4MfyTxynzkB4K9U4+Q==
X-CSE-MsgGUID: U6GnCZLwT5uQVTHX0CSQ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251359705"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 18:05:25 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:05:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 18:05:24 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 18:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC+Z279Ihw9M8fyJzaYacSPtuDcxBNyVXQumPqDJF3MqXiOibiwhuCT8oKqHn2nZZBOp9IANNPIEokTd/U8JsiyyX8NEGO8P7YdcxeMiKQRuWZ4IbqLKvHxn974oicNXRWdKd/hWXbqsvoZD2nqY+6oIW2ZrjIAcXHQ+65JWCBkSocLQEPcKHZiaqEUakrJEQFVXvoPl9kr/bCYE37VrsHRjbQfk93k/JXTRjyGmtVII2a04oX9E9bcGwPnekt3r8zbZRz2qZF9nevn3s/opOQz4nFCy2yf2XfthLhzYEkZKzlll3hk43PoFfd+rUMhpFeuivf2K3Xl8NW0U3MjfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYaKURdyw4Iu2i21HA4yxS9q10n8IpwlFd8ezTze2g8=;
 b=JprdGDssjtBybJfzSrkeX/rbIpUyGHuuc4Tk2mpjUGshN+37dlwNfd6Ty8/8v9RpUJAk+B3tn5pS2d6aSuUY2fLqZRqcSKt09ZuwVVyrZfMJf/5kWYZWFYGqNg13by8davQDWwcHeDK7NynUopWv25wA/66PKSAnZ5jC5VikTdKmLT9XdWEhMEvisW56xGhqtioFKzBQ3Gtg8OxLHowGQDtgIzv7nCoAWOqRmbsgtiNa9lHCI/bDHNAbCb2cCBzMNh/BhNwiLjaMRyiRdjloNPC/LwEArfrWiTa6N5QQa/TESXYOlSZbqMUHlImuikoYud7jlYdzsGnPlC7pnIpJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 01:05:18 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 01:05:18 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>,
	"Gao, Chao" <chao.gao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Topic: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Thread-Index: AQHc7LhTkBJCRmynDUGCQ1lB6jZxi7YgAfsAgACB1YCADimiAIAA1LqAgABlRQCAAE5egIAn3BsA
Date: Wed, 1 Jul 2026 01:05:18 +0000
Message-ID: <bbc43329805cdb164f240841b45ce0d5151eeb5c.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-7-rick.p.edgecombe@intel.com>
	 <ahVghgNAe4JrmlQH@intel.com>
	 <fe08f03a22acfe758cd97f7c2880deeafbc5fe58.camel@intel.com>
	 <aiGq7XjmMrsqdBY5@thinkstation> <aiJhScChLZkH44eB@intel.com>
	 <aiK1_q8beMcIEiwO@thinkstation>
	 <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
In-Reply-To: <572868d7-4794-4fec-b80f-97d8434d5fb6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|DS7PR11MB6127:EE_
x-ms-office365-filtering-correlation-id: 5f5fa22a-aa77-47b7-cc64-08ded70cd13e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|18002099003|38070700021|11063799006|56012099006|4143699003|22082099003;
x-microsoft-antispam-message-info: 50sJcQBUfLjxgaNaQPxlm9vseFSSstGxTVK3LDmRHYB+5+MyCvKb1H/Dea8jpOEsfdvd/3w/LmXJcZcU4Hnvt3DwosgBVNfIVnoWGdgIdVOqogwHlVMZb1ssN0j91cMLcWPPsiMaICYwdh8O2EX46D7c1s8TIlbv3pHWnEaGeEZ+M/sTMrBoVQ752PPrKqFkB+LuD/ILu7jTVSSOOqS6zI0ujSbwZ8IcHthJGFLsEu3jn3zsrnDUj7Ct4Ov+DrD+zaMpvA9nWDbdIACphcFEtyuScfQCKxZgQJqXnz4fyLyEUX1QVeu9FwJkjwSeMk2T5g1fjLrnPopwBjbtSmdmWF4pM7/S4u0TmSiQhatLhzGIJ4EJ/vpW0NNd5D7RjJSHOsahGhgVCqef2eJbD8PcAaoLW/KX6TXRrqN5TnzDkWeBc0mxF3w6VqhdKQX1jKQuv2OoIU60j5FuMtznLSuRYwUn7Z8T1jKW2wPAA4kioxTfnPypavb8ftk6IjnbORNU8bO8q8kWiYzt7lWL6fNJQOfoXjQjdmAvzqgWkfBSprY9BPjt/FR0WWpzPbmwLXhwslv1Ti5Jx+yBmnUJAdWgivIkGpSw6sgtx5QsQko+fW86s9wp2Tbhbl0Xg1YihfytP/26mJXBAehbBkkXUwtExpcgR2Kq7/noe9pTZMhhYnbeFL3xnehUIR1HH5aM2V0LJGvDiEOACJ8zN4be0tiekJhtVCotJdoLLgLVPImdpa0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBIQWRUZDRXNm9TblVRRGc5YklSRWI5NFZQeENkaTBFRy92MHBTeXRicDFE?=
 =?utf-8?B?TTQ1NVk4ZjlOOUJLY3FmMVBOQThnaW51WDExWS9XUksrY3A4NmdxaEZWOXRT?=
 =?utf-8?B?S29zcU5ja0tJZzh2c2xQNG5FV3JjcjRLMzdOeUgrMHBNZjBYR1BKZG1Sb2l6?=
 =?utf-8?B?VzE0UUNiNlY2dmp3M2dORFFlTm5DL0pRcTh1VGhZbGNrTVdUV0JFSDQ0NjhF?=
 =?utf-8?B?ZjNVL25PWnQ4OUlUYWFmdkVyWUYyR3R1SXZKbmRESER1TlBqOTl6NS9oa3E2?=
 =?utf-8?B?cGRhcDBzUDlrZGVsY3pHREJyam9zeGl2M0syV2FETWdLUW9WVzFGVkg4SlhQ?=
 =?utf-8?B?OXZCQ0Frd0V6Wnk0YXNpNXBiWmhtOWlqNFBxVFY0bHlEUTlyeHBqdUhmc0lZ?=
 =?utf-8?B?U0dhYWFVK0diUkFSU1dmbDllS05vMll0TTVDK0lVdmlvT0wxSkFhU0E2WVRl?=
 =?utf-8?B?djAvNEc3cXNiaEpGRHNuU0VMNkphTmxtWUdVNGVZS3dnSHZlS05RYzRpME96?=
 =?utf-8?B?VmZ6NnoxdVJFbjBoTWhwRzc2UFYvN1NHZXRzMCtQdm5wZEcySjNOT2pZU2FR?=
 =?utf-8?B?bDdjelNGUGRKQWZzZ1dkWkp6d0pLcXRMWmJhWkY1eFlBcndrMG1BYlpPVk5w?=
 =?utf-8?B?dEpsTEhYamt2T2pHV1BYZ1RpMWpIMU82VUY1bm5xWXRITHBDZEVSZmhFV3lP?=
 =?utf-8?B?ZVhOVjlPczA5NkJxUVBWcE51aFR3Z1pibzkyQVlMYVJGbDNjQnY5Z0tKSVFE?=
 =?utf-8?B?cVhsaEtSMjViaWREVG9MQ1owcFJuQkhmTHBRNGcvTzRlNmpPYUN2TlNDUGFL?=
 =?utf-8?B?MDVQdHBOZHpnT3ZlM0FqVUxRY1FCVW4zWitFanRFckwzcFJ1WitpamRKRm5Q?=
 =?utf-8?B?MTlZWDN3TG9NTy9qaWZQbmtXVHZUWUh0YmNyaWhrb0tvWmJHUEk4Nm5VSENm?=
 =?utf-8?B?UUJNSXBacjY0VGs4Qm1QU0FDTXFRYWo2V205Q0Q5dXc4UHNlMnNjQzFNZURx?=
 =?utf-8?B?ZVBEVEkrbFlHODdwcVFMcmEvb1NKaElyQWltVXBxV2Y4b0RxbTF3cnZkZGRt?=
 =?utf-8?B?KzNnSTEvNWhiUWJDcGhjRGpRTnEzMHFkOEVPUURLZEFKdE96QjB0c3B0RVF3?=
 =?utf-8?B?eXdVZUp6WXhBL2lvaTJ4RWJNMzhyNnNWQnZxWGExaVRXYnUyWDRhdFczdFd4?=
 =?utf-8?B?UzQ1YTNmeGlDUThhaThsZlRyYnFQdHdyWFcwUXA1ZytrejlsZmttaHN6SmF6?=
 =?utf-8?B?L1NzWTRKMzBtbWs0R1RHVTZVZzN3cXpKLzlJcGNqUjk1bTBzaGEwRHZHei9F?=
 =?utf-8?B?bUtXTFdNVDBmMWVZaXFpcHZGNEtqYS9vNVRlc2EzVGVlNzhwZG5TbG1NbTRX?=
 =?utf-8?B?bTdOS0o2Y2xvQmlMTVNSOEEzMHQrVzh1d1FHV21nNFhKcnoxVW54TXVaemdF?=
 =?utf-8?B?bzI0MEh2U3FUZHdIR2Y4ZG54bkw3MVNpaGdkVnlNRU93ZTRZWWw3TUFNa0FR?=
 =?utf-8?B?eVRuY0NNeWE0VUxQdUJXNXFIRXlJdVlvS1VFQ2czcm9PL0FvRlBxK3pCWFZC?=
 =?utf-8?B?NWpRdFQvODJhMlJNd21LelBuMmI3NnRzeG1FZ1RWSzR6Nlh3bjE1Mm1vOTNo?=
 =?utf-8?B?U094cGkrZFFkOTBza3RzOEh1a0ZBZFcwQ2QyTStpWk9FVmhEUytuckN1Nk1v?=
 =?utf-8?B?aWdyeEJxZmduaVJPR0dhNXJjTi9TWGdLRTExMUNWWk53TlZIWUVFdnNEWnZa?=
 =?utf-8?B?dmx2MlVjNWVuOUxtSGtGZVo5djFOVENDVXdHbmwzcDJFcEZkemVESU1NdytK?=
 =?utf-8?B?bWVUb3RoWXBTL0tER0kzUWJqMmU2MHF0YmkyS1l2ZTdtRG5RV05FZ2RvRWF6?=
 =?utf-8?B?YjVyTC9INjZVSnVTQUQxcGczdVYwcHNWK1ZJVUZPSXpKaURpeGxtQ3J2L0hY?=
 =?utf-8?B?eG9TaHNudDJEQTMzd3lYaGNNaWJRT3VJbW1RaWtLYndPYWNRb1BtRHB4Wlg4?=
 =?utf-8?B?UVFFd251UnorRUNPa3V2WDlzNjl3ZWgwc1JscTZqbkJvZ1VTWWxMUUJPU2Nt?=
 =?utf-8?B?YVFsK0FGNkt4SjhTbXh2ZE9sWEU3UjhJT0xYR3VheVFWZDZGSGxDdklvbEVO?=
 =?utf-8?B?YUNja0dTR253aDNBOWJ5K2N3RXB3STU4WnFrUXE0YjI0eWhKOGlwanRYb201?=
 =?utf-8?B?a0pqdGlMNE1VdEJSUnZ5cS85TWNNS3RJWDg5L2JhTVA5RXRGNkVDOHRjcXNs?=
 =?utf-8?B?bm5mT3d1SlNNWnFxT3plNnZ0R3ptSERRL0xDWUUxc2RIVzBDcVdwMVZUeFNC?=
 =?utf-8?B?RWt2M0NYNGhoZGFQdmkweTYwUUpkUC9Uc2tPYmhFNmtLZlloYnYzZ0ZEemht?=
 =?utf-8?Q?y4BrREV7CQZC6HlI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC4BF8AFFD23C0408BD95A2FE7294390@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VagLLGndGpc5mgsf5ed8hUNWtjZ7TspERin+fxTn5LS/ebGrNEHs87IRs43ACUJON6eMF+anYdJQmLou3N3KR5zDa0WYOcnoVTVeB8iXN4fOOMfvpdHoLpOpqhRWQDXPJLBuURFuG6ptfUAQJp0MrJTWmNfKYWTIYihlz1q5fYs5gj6/rSRLHEZkz5v3HH/WTvG+cSaLbIOGl9w49bLsPiqjUx7y2YzgGPS8IK2VmqzR1+umxbxOf4NQ2/8k6frz9FgkeWp730ugB9uU5R8rSVPEUxL1WyEh99DlHmYQA9akhdfZxloPSt12t69l69uVt0DX+PD39ealz4Gbn8QU3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5fa22a-aa77-47b7-cc64-08ded70cd13e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 01:05:18.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SLyg5bh0ux8J8TlTLsHmGVr9g/+qTXrdpf9V2NRwdsJUQVUEVqXHtj1SVqWiFKKSwbBMPw20eazS47R/7lgtwY96HZVf+r+vk3LN8TPE8x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjIzIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNi81LzI2IDA0OjQyLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6DQo+ID4gPiA+IEkgZG9uJ3Qg
c2VlIGEgcmVhc29uIHdoeSB3ZSBjYW4ndCBrZWVwIHRoZSBzY29wZWRfZ3VhcmQoKSBvbiBnZXQg
c2lkZS4NCj4gPiA+IE9uZSBhZGRpdGlvbmFsIHJlYXNvbiB0byBkcm9wIHNjb3BlZF9ndWFyZCgp
IGlzIHRoYXQgaXQgbWl4ZXMgY2xlYW51cCBoZWxwZXJzDQo+ID4gPiB3aXRoIGdvdG8sIHdoaWNo
IGlzIGRpc2NvdXJhZ2VkLiBTZWUgWypdDQo+ID4gPiANCj4gPiA+IMKgIDpMYXN0bHksIGdpdmVu
IHRoYXQgdGhlIGJlbmVmaXQgb2YgY2xlYW51cCBoZWxwZXJzIGlzIHJlbW92YWwgb2Yg4oCcZ290
b+KAnSwgYW5kDQo+ID4gPiDCoCA6dGhhdCB0aGUg4oCcZ290b+KAnSBzdGF0ZW1lbnQgY2FuIGp1
bXAgYmV0d2VlbiBzY29wZXMsIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0DQo+ID4gPiDCoCA6dXNh
Z2Ugb2Yg4oCcZ290b+KAnSBhbmQgY2xlYW51cCBoZWxwZXJzIGlzIG5ldmVyIG1peGVkIGluIHRo
ZSBzYW1lIGZ1bmN0aW9uLg0KPiA+IEZhaXIgZW5vdWdoLg0KPiA+IA0KPiA+IEJ1dCBpdCBjYW4g
YWxzbyBiZSBhZGRyZXNzIGlmIHdlIGZyZWUgdGhlIFBBTVQgcGFnZSBhcnJheSB3aXRoIHRoZSBn
dWFyZA0KPiA+IHRvbyA6UA0KPiANCj4gSG93IGltcG9ydGFudCBpcyB0aGlzIHBhdGNoPyBJIHNl
ZSAiT3B0aW1pemUiIGJ1dCBJIHJlYWQgIk9wdGlvbmFsIi4NCj4gDQo+IElmIHdlJ3JlIGFyZ3Vp
bmcgYWJvdXQgaXQsIG1heWJlIHdlIHNob3VsZCBqdXN0IGtpY2sgaXQgb3V0IGFuZCBmb2N1cyBv
bg0KPiB0aGUgbW9yZSBpbXBvcnRhbnQgYml0cy4NCg0KSSBoYWQgZG9uZSBzb21lIHRlc3Rpbmcg
cHJldmlvdXNseSB0byBzZWUgaWYgdGhlIHJlZmNvdW50IHNvbHV0aW9uIGF2b2lkZWQNCmNvbnRl
bnRpb24gZW5vdWdoOg0KICAgVjIgb2YgdGhlIHNlcmllcyBpbmNsdWRlcyBhIGdsb2JhbCBsb2Nr
IHRvIGJlIHVzZWQgYXJvdW5kIGFjdHVhbCANCiAgIGluc3RhbGxhdGlvbi9yZW1vdmFsIG9mIHRo
ZSBEUEFNVCBiYWNraW5nLCBjb21iaW5lZCB3aXRoIG9wcG9ydHVuaXN0aWMgDQogICBjaGVja2lu
ZyBvdXRzaWRlIHRoZSBsb2NrIHRvIGF2b2lkIHRha2luZyBpdCBtb3N0IG9mIHRoZSB0aW1lLiBJ
biB0ZXN0aW5nLCANCiAgIGJvb3RpbmcgMTAgMTZHQiBURHMsIHRoZSBsb2NrIG9ubHkgaGl0IGNv
bnRlbnRpb24gMTEzNiB0aW1lcywgd2l0aCA0bXMgDQogICB3YWl0aW5nLiBUaGlzIGlzIHZlcnkg
c21hbGwgZm9yIGFuIG9wZXJhdGlvbiB0aGF0IHRvb2sgNjBzIG9mIHdhbGwgdGltZS4gDQogICBT
byBkZXNwaXRlIGJlaW5nIGFuICh1Z2x5KSBnbG9iYWwgbG9jaywgdGhlIGFjdHVhbCBpbXBhY3Qg
d2FzIHNtYWxsLiBJdCANCiAgIHdpbGwgcHJvYmFibHkgZnVydGhlciBiZSByZWR1Y2VkIGluIHRo
ZSBjYXNlIG9mIGh1Z2UgcGFnZXMsIHdoZXJlIG1vc3Qgb2YgDQogICB0aGUgdGltZSA0S0IgRFBB
TVQgaW5zdGFsbGF0aW9uIHdpbGwgbm90IGJlIG5lY2Vzc2FyeS4NCiAgIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI1MDkxODIzMjIyNC4yMjAyNTkyLTEtcmljay5wLmVkZ2Vjb21iZUBp
bnRlbC5jb20vDQogICANCkJ1dCBJIGRpZCBub3QgdGVzdCB3aXRob3V0IHRoaXMgZ2xvYmFsIGxv
Y2sgYXZvaWRpbmcgb3B0aW1pemF0aW9uLiBJIGNhbiBsb29rDQppbnRvIGl0Lg0KDQpUaGUgb3Ro
ZXIgd2F5IHRvIGRyb3AgdGhpcyBwYXRjaCBJIHdhcyBjb25zaWRlcmluZyB3YXMgdG8gbGltaXQg
dGhlIHNpdHVhdGlvbnMNCndoZW4gZHluYW1pYyBQQU1UIGdldHMgZW5hYmxlZCBzb21laG93LCBs
aWtlIGVhcmx5IExBU1Mgc3VwcG9ydC4gQSBib290IHRpbWUNCnBhcmFtIHdvdWxkIGJlIHRoZSBz
aW1wbGVzdC4gT3IgZGVmaW5lIGEgcG9saWN5IGJhc2VkIG9uIHRoZSBudW1iZXIgb2Yga2V5aWRz
DQp3aXRoIHRoZSByZWFzb25pbmcgdGhhdCBpZiB5b3UgYXJlIG9ubHkgYWJsZSB0byBydW4gb25l
IFRELCB5b3Ugd2lsbCBhdCBsZWFzdA0Kbm90IGNvbnRlbmQgd2l0aCBvdGhlciBURHMuIFRoZW4g
d2UgY291bGQgcmV2aXNpdCB0aGUgb3B0aW1pemF0aW9uIGFmdGVyIGh1Z2UNCnBhZ2VzIGlzIHNl
dHRsZWQuDQoNCkZvciB0aGUgc3ViamVjdCBvZiB0aGUgYXJndWluZyB0aG91Z2gsIG15IHZvdGUg
d291bGQgYmUgdG8gZHJvcCB0aGUgc2NvcGUgZ3VhcmQNCnN0dWZmIGFuZCBzdGljayB3aXRoIHRo
ZSBvbGQgcGF0dGVybiBmcm9tIHRoZSBiZWdpbm5pbmcuDQo=
