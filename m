Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24B1DB551;
	Tue, 28 Apr 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402508; cv=fail; b=GGCRpR66w0F4mc8WInJa5q6hVe4t1nc+gkRsJ8f4INCwXWXQ+pTNbqmzmz7U7vxECDELKiieyURJQJ16lzTY89HF7xMRGZ/AOjb13XkmdIb5SAyo816MLFNV4WGkw07e82sRshcVB9VeTkwBIUsushwSWIffgREiIdcwdOkaeUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402508; c=relaxed/simple;
	bh=HxX9KGE0OtrifJAJdjUGDTD9SbVjVXCzf5UOh6RGrVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPNGpVupyFYSESe7P4bDqez2aeZA3fjm2LvntjtyYu0XPELFrvToF5cOAsUQN1gyMV1GeC8s+P7ETigohK8dOvjYqKkW8ty25EW/RQXNPXFmuF+TKr7Xg77kT0xXQmve9AB44ADF73BRiKLH7yCd7b0uHYguDPs49qsTkZCHkfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZX60s2r; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZX60s2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777402506; x=1808938506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HxX9KGE0OtrifJAJdjUGDTD9SbVjVXCzf5UOh6RGrVQ=;
  b=nZX60s2rv+kgtxY0LpSfKNSaC4yEKdA5DfhJ7TkxbAYdXIo51r4Y+ueg
   S2EM1BQAUVQKvXgh2LvsYZvUbyG9QWOcmUiGJ5sPaVR8CKkc5/guDz0qp
   0fKfsmSsMkqs+IbMVTErKXQB0ZT9HOTx4UEd2E1CUkStuexF8VU8nozqK
   XhQGyofSsHypJaBC/uX/YcZEEsHQIGooIPDKGsLeNhlVVvwQvSlwCGpwg
   hIozKChB9XGeG/kLHioEtat1+inb5ANVMBQ0HT26Xmeed/IkYRsdjxL+G
   Yj01jTm69vFJCtB1kpykGfdXzSD/SYOhJNlqeAtFMPVOMoq9Kf24HkvIQ
   g==;
X-CSE-ConnectionGUID: pPsnug3dRGihAx5bTURlLA==
X-CSE-MsgGUID: qpC2fHE5QLegKZTgIXvBmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89019638"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89019638"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:55:05 -0700
X-CSE-ConnectionGUID: 3Q31k/5vSI+jSD8weHobHg==
X-CSE-MsgGUID: 9Sy0Bp6+QZG5jlVFvxP63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="235793153"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 11:55:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 11:55:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 11:55:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 11:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbmfbFD2DUgCuhvw9WY1GnvYMCDJeclZondghlO6VkA/tUcJSLciCPbDn6/0m11SOIdNScaWx3IjY1OTWnU03ttlyTXgMjGIT7sBadCpCt98dwEpDB2Q0DxzN4FC6/W+WjC7JAhHJDldFl5JlQyLtt+PXwMbpdu9GgO/3OtsJ59QzK3sxEKqi4nIu2Wqu9IQyDoI6ZxpuvM+Qngx8+nEVuxzibpbAOGd3Ja8HBp8oUhFnzWLvCb4hvmpybL7en+7CmavW9BkMK+SlxjieTLAtL8szgEBMoiF6gldeLZteFb1kSTjhpB5wTclT6r9locBf9AF3K8LrGWjB8zMTerWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxX9KGE0OtrifJAJdjUGDTD9SbVjVXCzf5UOh6RGrVQ=;
 b=JuIb8I+SgLF6nMlyr1RPigyk0n0P7hdmmFyJScgP5Cq7yGljq+LibNsJsR3HvMx7JcHCA06tDj103ZR+W80j9Ruj3lcJ4RBu1kLplyBgYuhoOSfCRwTXOefhYF37hxfgj3LNeuGaIlf9wgakrL047YSbKXQkjwCwsrriRMXJBH9eYoamrbMLhDiNBFVpcR5twobmwXxTnVVBj/Yl6UfaWyqDUGoYhcytm0H/4Idjuf3C/63WT3HxLCY5jtUuNjyDUIDB0wRbN9TLFXvqUeYdCd1MpA9v440G+MOFR4sPdG7We2Qsw6KbZoLWPWwKV5WhWmLqAtAqvmeoySTC5GhbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB9130.namprd11.prod.outlook.com (2603:10b6:208:56c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Tue, 28 Apr
 2026 18:54:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 18:54:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "Verma, Vishal L" <vishal.l.verma@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Gao, Chao" <chao.gao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>
Subject: Re: [PATCH 2/2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Thread-Topic: [PATCH 2/2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Thread-Index: AQHc1rjfC7iJWArlKkC4A9pewS8Gk7Xz+2GAgADYLoA=
Date: Tue, 28 Apr 2026 18:54:55 +0000
Message-ID: <02608364855a47fdec6e519470321e1522435990.camel@intel.com>
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
	 <20260428024746.1040531-3-binbin.wu@linux.intel.com>
	 <36c64a53-0041-4638-b6cd-7deff38bd37d@intel.com>
In-Reply-To: <36c64a53-0041-4638-b6cd-7deff38bd37d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB9130:EE_
x-ms-office365-filtering-correlation-id: 780d34bb-232a-4d44-ab65-08dea557a398
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 0x5brOvFBteRUu5GMSUAVL37C6OYZnHwZjcv0pCl4HRhJ7NP6akwxnFbJW0qhJqFPdvVCu16wL/l6Hai/h9DVMF9joEdt18q5vn/kFx1hEfN0a4y0rgOCcdCrT/MENKnIhRRtylgSmJGgsyjX2RL2vDTJglElcyj7ADlNw0uiHie8W1gkh0AAMrIXqCTyEXRYSnkbAuGVNwtwM/ZFYIPNciAOQ6it3PojKyu0tyJ8bcxHoC2bzhBorKFf9DaA/xFc51Q3zP69gC29S/rpT8T+5VgCN4tFEzTVCGHMqSpUYqndHuqpdsFEtlcae4l1/rkl3t3zQaOYfyJxTeLwetvyI5iXm+ZA6DAJxluxNcG9nsKLI0Jj9iEZ1MAgxWf3uxIEsWmsFY6vyimShX/LLQTRmjaEY3Wf7FgJkyQ492cfpWX4L7AvuNFVtLbZCtQskM+PVE1M9i6pe1WLltcu3rf2M+u9WmBh7MIy2bDZXxMzDJV7kwfuv9ME8bH6OAa3bNRULTkDIslrLlYOKGoHKggWoQ/pxz38KQt27PL/oCR1+l2illjd2bJ8jXY0dXeFnWIc6Zpdk8tE7jcZU+oLFd6jGPToj8PTAteFc+J51rnw8C8BoTFqoQai+xBsPnZ2fRV0JxNlbGhOq8XDtkrs108+8mskKbFKKeL6sv4sZ+wTtyLIcWO90/pkizwkrLlaecl9v5wKILVmWvD5HFjjh5nNApx48hziSlCsppYesqoouRIKL5shXdjylG9FmLkPEp0OmCP9iB2pnrL9YZkMJnWsn5BoJkK4low0Gyyl5jrRu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVhxYmxNUDJINkNIeDk1NUtVU2cxSTJsOHlVQ1dRY2s1eHVJT01sajRSc1Qv?=
 =?utf-8?B?TFBLQnYrYWtkMEFCWGM0MDA2K0lkdUx6VWxpQjZlRGpKRytqUEZxeTh3Ylpl?=
 =?utf-8?B?WnFRMUJtbTRBWDJmeVduSGhaZng5ZDczcWFPczgzY1NsdEhDaWlZekMzandi?=
 =?utf-8?B?OUZSVlNSeklEeFBXMnRnTUh3L0o4d1RVQkQ2NW1GRWllVmxtRktjcUorbzBn?=
 =?utf-8?B?TnFrTGNvcUR0UVpvRDYvdzhpbzdWSkwwcCs3aDk0akFhUWpZZ2dsKzltUHAz?=
 =?utf-8?B?NDRGNUVpSXg5Wk8yNEdNT0F0ZXRGcE1aSTlIaEpvVXZyNjhYemQ2a1o2OFRt?=
 =?utf-8?B?aUh3ekxtSEp5RzlZNnFlbHVsVVI1cjk3L3hUTmpDNDI1RUFxaUVza0dLN29v?=
 =?utf-8?B?N3B0TEhONDluSzUvMGc2YUxSbWtzMS9Lb1VUUFFrUHo2Z042cUduSnMxT093?=
 =?utf-8?B?NWc2Kzc0UFdVV2ZBOTJsbmJtZWlJTjFRalZad25mYmgzTGZKQ1ZOT1cwMFpV?=
 =?utf-8?B?QXEvUXpnVTBZM2ZUNGNyQ3BQaDF5QTBmUkpvb3F1eGFid3Z0YzNOL3NYTVls?=
 =?utf-8?B?Ukt4VlBPUk1zUm1JU2VRRGdMR3FuTFFSTExNcEs0aDBEdDljNUR2SWxndUc5?=
 =?utf-8?B?azYyNk0wWHN1RkVmWU1RUEpLY3RKbnIvb2JMdi83V2NMNFROdFFHdlBIR0Vt?=
 =?utf-8?B?ZDNYTXJmWUduTy9FSXB1Qll4bkx0V3FqRXVFYXJCOVpydzNJUXhrMzdodU02?=
 =?utf-8?B?RTRrakIrWU5ETW9Mc2k0RVB2YlRab29sd0NIeS9IU2xmaldtQnl4Tlk5aElS?=
 =?utf-8?B?TVNRSjRqMUxIYzJEbU40bTRNZ1FqRC9qcEV4amRxakVtNkFWZXJpY29wcHdy?=
 =?utf-8?B?NGg5TGw1QmowQkpSQkJoM25GZk9Tb2lUV3ppQ3VXL3dvOHFLOGE3cXlHbHF2?=
 =?utf-8?B?SVZ5YytwWUpQWFJ6L2NkRG9Db1Y4NzJyQlZ4dUJNYXJtL1g5eVdSSmZQaito?=
 =?utf-8?B?dklyUFV5WVhENm5yMWt0aEFJYy9VL09VaHE2ZDAraWdOVW1BNWNZRVZGT3pQ?=
 =?utf-8?B?ZnlPSlB0RWgyd0dRRFFiM3ptVGNpOWgwSHlLZzYwa3AzWllKWmNsaVhzWXFC?=
 =?utf-8?B?L01xcFFwWVZQaXl4TUpsQjd3c1AwZ3cxbko1R2VaL3BQa3ZxRTlMMlU3UDNK?=
 =?utf-8?B?aSs1STVlSkFtYW9JN3M5UXFVZmJNNnI0MmJJWEhGMUdwOEJJSTdOUGpkLzZP?=
 =?utf-8?B?UDU2TC9wRnA2SCtoNkE3OVpjUjlYSURPaXI5Ynp3dTJaOU9JVkZIWnNCRnVQ?=
 =?utf-8?B?cTBXcFdRRzIzRVZ5bTU5Wk9iUjNSTHdOSWMzY2lQT3YzaVFmbnBPWk5TaTN6?=
 =?utf-8?B?VzJadmdsc3l2M0dEMi9HYlpxZXdpWGloOERCVjNSMDdUUFErbjkwRXVtb3Yy?=
 =?utf-8?B?VzI3eXNpenVIa2hXcXFFdW0ycmlrbmlHSHFxUGdYdGRaTlRzVVl4ME5Zazdp?=
 =?utf-8?B?aDlqMXhiN0lGd090MkNxeFRWWVZDOUtzV081R2tkc2tSUlFTM0tFVFhoalhY?=
 =?utf-8?B?K25iTTRlTVJlNDVvdVFmZUZUSHVZNUNTR0laaW9saUpCeEpRUWs2S3lITVpM?=
 =?utf-8?B?c0laWkhVaXYwbURWUUt5NEFCZDFsMTZFOTJxZjNweVcraEN0MHlXclJPVlNp?=
 =?utf-8?B?YmkzZkVWa05jUDVBYlA3VUsxdWFrRnRWMG9PVy9qeXpGc0hwNGlSN2dRU3Fh?=
 =?utf-8?B?YjRCdkhmY2J1VlErd0hLekFiVnVEaitvVm9la002QU5KNHFnSndHMUc2UDd1?=
 =?utf-8?B?SDJtdlJVQVduVkVJMUd6YkhzNUExVDZGKzRzMHB4eGhzOGhML2RJZytTUFZi?=
 =?utf-8?B?Wlk3K3U4UkI5cndxNUlDNENYZnBvVFhFTEQwZ2dSUHQ2YlFhUTNrbHc2NXlO?=
 =?utf-8?B?c1VFa29NRi9qVlArbFQvWi9SUGhObU9ZcEdoYzU1bnhLVktpU3JJWjZyU3JP?=
 =?utf-8?B?Yjc5eVVodGJTbmFTMTNEZmZ4TWozeXdYTGV0c0dmYW0vR1B0bkMxNGtyblJW?=
 =?utf-8?B?a1hJNnNLNE5pQVY4Sm5mbVV2UUV6Z3dHU2x2NEttcHBGa2Fmak1uN0tDSktW?=
 =?utf-8?B?eHR1OFR6enhtZ1liZVFqMXNvZmJqbzZURmxSZ3JOUFdKNkVBdWVnMkQ3RkZW?=
 =?utf-8?B?KytsMWlYQ29udjFTMzRQNllqMk9IZE1ocDJXeExuWGEyWnFDbDNJZkh6MzBh?=
 =?utf-8?B?OGdZdTY3UTJxd0JqNFFQNVI1eHgxWCtPbW8xcDcvTmltcXVJaXd2eG9mM0dU?=
 =?utf-8?B?WVpDM1p2QVBOYXVCb3RnWlI0anEwNWIwOGpZdm9malJMMk0xVStKNVp2a0lv?=
 =?utf-8?Q?yRuYGzSztXCC9oW8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <895C5923C6F256419B5BBCC743A97859@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PQOdiN6SCuMUP/S58kIWh/u/mjJCX4zVq0HI4U9M2Gat5kY05Kae0VUSTrhY4xRvh1338fB+V4lkpE1RlAncT6/T1/+fr2r6SDk2N4TlgUZUZpwGQPioU5GPs05Umx0nBDjUrhETqnQ19zvZfZI/i6vqxZVIa32oHGYapF39I1++ccpkvrnVVa6uoPrh9ucD0D9eD783ePEoKYUTupg7TrRQMOflPaG7stIBLQVqb5D6t5Wzsm++6ucGv4YmMHzBmWCwbvXtuhk92gCJ7RLsJLzWpBuQOIaPN/8nK0pTykEkrv6cDONBui5oTHt3Wal5Q6/JSzAxPcIsiPR5DK9l7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780d34bb-232a-4d44-ab65-08dea557a398
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 18:54:55.8439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCN4mqFBpFGDz84PluF++NPkRJiJWfBlQdMBCkZqmhsYPtpRvsY+r57miz90In+GQ7EpDj5+WnheGhsNAHuxIHka93w5YetA7u+Z6k0P7q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9130
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTI4IGF0IDE0OjAxICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
ICsJLyogRG9uJ3QgdHJ5IHRvIHJlYWQgbWljcm9jb2RlIGJpdHMgd2hlbiB2aXJ0dWFsaXplZC4g
Ki8NCj4gDQo+IFRoZSBwbGF0Zm9ybSBJRCBpcyBub3Qgb25seSB1c2VkIGJ5IG1pY3JvY29kZSB1
cGRhdGUuDQoNCkZyb20gdGhlIHNlcmllcyB3aXRoIHRoZSBibGFtZWQgY29tbWl0Og0KICAgVG9k
YXksIHRoZSBvbmx5IGNvZGUgdGhhdCBjYXJlcyBhYm91dCB0aGUgcGxhdGZvcm0gSUQgaXMgdGhl
IG1pY3JvY29kZQ0KICAgdXBkYXRlIGNvZGUgaXRzZWxmLiBUbyBmYWNpbGl0YXRlIHN0b3Jpbmcg
dGhlIHBsYXRmb3JtIElEIGluIGEgbW9yZQ0KICAgZ2VuZXJpYyBwbGFjZSBhbmQgdXNpbmcgaXQg
b3V0c2lkZSBvZiB0aGUgbWljcm9jb2RlIHVwZGF0ZSBpdHNlbGYsIHB1dA0KICAgdGhlIGVudW1l
cmF0aW9uIGludG8gYSBoZWxwZXIgZnVuY3Rpb24uDQogICANCkJ1dCBpdCBpcyBzdGlsbCBvbmx5
IHVzZWQgZm9yIG1pY3JvY29kZSBzdHVmZiBBRkFJQ1QuLi4gSXQgc2VlbXMgaXQgd2FzIGp1c3QN
Cm1vdmVkIHRvIGJlICJjb25zaXN0ZW50IHdpdGggdGhlIG90aGVyIGZpZWxkcyB3aGljaCBjYW4g
YmUgbWF0Y2hlZCIuDQoNCj4gIEkgZG9uJ3QgdGhpbmsgDQo+IGNhbGxpbmcgdGhlbSBtaWNyb2Nv
ZGUgYml0cyBpcyBwcm9wZXIuIEl0J3MgYWxzbyBzdGFzaGVkIGluIHN0cnVjdCANCj4gY3B1aW5m
b194ODY6OmludGVsX3BsYXRmb3JtX2lkIGFuZCB1c2VkIGluIHg4Nl9tYXRjaF9jcHUoKSBhcyBh
IGZhY3RvciANCj4gYXMgdGhlIGdlbmVyaWMgRk1TIChGYW1pbHksIE1vZGVsLCBTdGVwcGluZykg
Yml0cy4NCj4gDQo+IFdlIHNraXAgdGhpbmdzIGR1ZSB0byBoeXBlcnZpc29yIGlzIHNldCB1c3Vh
bGx5IHdoZW4gdGhlIHRoaW5nIGlzIGtub3duIA0KPiB1bmFibGUgdG8gYmUgdmlydHVhbGl6ZWQu
IEZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIG1pY3JvY29kZSB1cGRhdGUsIGl0J3MgDQo+IE9LIHRv
IHNraXAgcmVhZGluZyBpdCBkdWUgdG8gaHlwZXJ2aXNvciBiaXQuIEhvd2V2ZXIsIGZyb20gdGhl
IA0KPiBwZXJzcGVjdGl2ZSBvZiBnZW5lcmljIHBsYXRmb3JtIElELCBpdCBzZWVtcyBub3QgdGhh
dCByZWFzb25hYmxlIHRvIHNraXAgDQo+IHJlYWRpbmcgaXQgZHVlIHRvIGh5cGVydmlzb3IgYml0
LiBFc3BlY2lhbGx5IEtWTSBoYXMgc3VwcG9ydGVkIHRoaXMgTVNSIA0KPiBmb3Igbm9ybWFsIFZN
cy4NCj4gDQo+IFNvIGhvdyBhYm91dCB1c2luZyB0aGUgc2FmZSB2ZXJzaW9uIG9mIFJETVNSLCBp
ZiB3ZSB3YW50IHRoZSBlbmhhbmNlbWVudD8NCg0KV2l0aCB0aGUgY2hlY2sgaWYgd2UgYXJlIG5v
dCB2aXJ0dWFsaXplZCB3ZSBjYW4gZ2V0IGEgbmljZSB3YXJuaW5nIGlmIHJ1biBvbg0Kc29tZSB3
ZWlyZCBwbGF0Zm9ybSB3aXRoIHRoaXMgTVNSIG1pc3NpbmcuDQo=
