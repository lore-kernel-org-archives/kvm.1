Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DE40DFDE;
	Thu,  4 Jun 2026 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571889; cv=fail; b=ugRmq83dwUVYR8bRq0ct8FF3WRU3UugaVUXhB03yMfpMRuS2ZUbXo0aQVI+gEgWMHETxBOrwM49rCBKsjew5v3nZo8f/rLvrxQNXkgWueMERa0yY7aIbeC1snr9G4JNoQR6ekkHku6DbNUqA++L2pNuzQekelgqw5MF3RcX5enM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571889; c=relaxed/simple;
	bh=m7x/OssR0Q0VK13Rk2aEMhKR8+l78UE80kUr2DQmdkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q80aKGJGGQ9qxfZlS57k601LVtuD0BbbewRKWHNyIqQhotwlKF3pyvIb5sN20CHRxIRFDv+a69aph+NYM7of0ocOcLGNShu7Quuzy0p3TJg8hRQgWwHRLelFQAOS6R6I81MtzN08cSEOX6nTDAbR8wr0bzvp1vDOI4oL2AjZXFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3kuyJAO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3kuyJAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780571888; x=1812107888;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m7x/OssR0Q0VK13Rk2aEMhKR8+l78UE80kUr2DQmdkc=;
  b=X3kuyJAOBcTzvI8vwwb4xH/EeP/hDTn5L2fut5pUKZC9P99NqeP1P5VZ
   KToFhsVDZJP7LdkDt/qnBzIZ6704RHFKMlKMvdbo+tjVyI8n9OW1rlc9s
   VoqN9vH5S8pSzndKtiTBrEA61dqIO6ztLM0MDFLE2+6NsGFSd224AdZVg
   r13NNdiuGrj62K++ryMaT9QIq+j/zszkCEZEtCYrhoNxG/3zXztsARBga
   EARptPmWOg3O8NQH6FlukzjW0Kft6BwPlVZJ9YW/B02eVvxeNtelke1lT
   aNdY7Luh2Ooe4gmJsLgfoXLtOZqjLhcklrIv8YUwRy+p6poTKVAyNbWs3
   A==;
X-CSE-ConnectionGUID: vIGECz21Siux8gzerYbY0A==
X-CSE-MsgGUID: E2HuUS3bQnm9euoL7mH4fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="83973157"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="83973157"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:18:07 -0700
X-CSE-ConnectionGUID: VZT2rqx1Q5yBmNg2f5amQg==
X-CSE-MsgGUID: B0hPvKfZR0OowKbOXD5epw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240321318"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:18:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:18:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 04:18:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMqJeYvyYsw7kywX0j/YDH1tjIa7cPU89EQq+fV/0VW05NBIf4Tp35W137BgKrixS2N/qSj9QqaDfFsSo0Ixm6ptkjh6I8tP6gLl1B4HIUmUUGfQfHFaSHmAk21PJXgPCBwFclO5yfKlNNPNJ3ssDDqGcqVGmNZfzc4bItMDg61zvPZS2fn+nfb0yZp2D8A65hBrN0NFYSjwF5Z9hC4aB0NraWwiP1k+Bc7etsqojd3NYKjTXkp3cfzqxDD0ALwfzkrzBqxFdtqbEQlLNlBx8uUcW/W0ohbkC6EjGVQ7W/CCspiG7hygOjMCeE71kN4CM0F5E2ZeFtCJk8MKQT5new==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7x/OssR0Q0VK13Rk2aEMhKR8+l78UE80kUr2DQmdkc=;
 b=xDbHOkOIYIRE8y9AoaErYAFjxZHjPUNCSuxHo5+Ofa/L6RYlBjmVhDZgF/DcFf+Z+bLQvF9NPYoy4EKSkM1nLq2UFKvJyHK3nOmuIfGdxzUhtP16COpBmTvzX4U0AsONg0cx8EvyG68Tx0usZ48gBWWSH/Pj2hjZCFju40EkpRs1IYrwY3AUEP22RLeY+qUTdUlKmnaf2HBqZWGCgzx7MNfVl3+hRCaU1Lw91nlQyFKnd3oILZMXG1JZMmXFIP5gujRISm9iSbNwOS6gmQMBd365XVQc8pQeemes76LqvnBqN1vLvFYkXBlr1DzZasepfan8xmBprmgBUkpMMRGZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 MW4PR11MB5935.namprd11.prod.outlook.com (2603:10b6:303:18a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 11:18:03 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:18:03 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 24/40] KVM: x86: Extract get/set MSR (list) ioctl logic
 to helpers
Thread-Topic: [PATCH v3 24/40] KVM: x86: Extract get/set MSR (list) ioctl
 logic to helpers
Thread-Index: AQHc77nGR7wJyEozdkmSf7sbpuIamLYuSCiA
Date: Thu, 4 Jun 2026 11:18:03 +0000
Message-ID: <94340f75081eb252e983f77a4bcb42daf48d6921.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-25-seanjc@google.com>
In-Reply-To: <20260529222223.870923-25-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|MW4PR11MB5935:EE_
x-ms-office365-filtering-correlation-id: 33e374b9-0c25-43a3-f21f-08dec22af202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 072eHfWTb3P/38pPHcjFMpjIWDolJ+HfHOiVhSS/YjELRckf4ZNjtjM4hZIxKFXO+CB+tdRZwe8LxMXyuE1aqbHxm9NI0ec/m8fbKfrRt8Lb7KamovSN36Nyt1Su1E4PSPZ2NFf8CepcZ2e9OnJJrxsLyGgwoyiWIBXCta61jJmxrAiYyCvP274VPg7HuPq5ehBMCTDQc+YstZVzRAOhSJlosf5ZtrKkwD5IP4BsJmVZVSgTC8RuTs2OC+8LH9qebvH2JIRMrrjyrZFuGfdvjFhCmBYdvYgCpt2J0JIxTHAI2enf+Ov7B8RJttCbtkVQYXlQsswHOuhdDIfuofbQDF9aIH9qwIxPd1/Ke8Ys1adBzHh7HTNELoYprfbtbMb0RAbuftNimDXKPpKwQINIBbU2bXQi7T0WnH+XbK680KqHMDEPvbsXHe0Wm+8K6lqerbsIecGN85ZDeSD91qGucGbDa+woNFDWej/2sE1rDUlX7fLBRmAsvi/yp+9BOtlUqSQnhYdlNECRQHevwciibuGzuBMmGYhkYG3vqmMie842ayLXW8waH0dqYvmx9lB1BvXk/tFta0ePvBNixn/J7jTpeEcdIuRlX5mhlUJylNxlrFwtYQc1iaby+XzfvKMxNMMLdI6eEkCwU4RCGXl2+ir3xZTdO51ZruTToOSTndgSCSWNCu37HlztUNXYhKhAfKaEkE3E5lH2lQ0Usz7touUueJ0SFVtr5Wg54IiQnXtQxu5pIGFwDydI5yrbfE1z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUF4UVVFZm5DS0VTUVdnWGppYlcrZk9aN256NHFnM0tzcm9wNUNJQ01HVDY4?=
 =?utf-8?B?eFhCR0hIVEZUUTZIdzlEOXo1TTdVRmI0SlZ1MHEyY3IzV0JNL0hwQ2MrOWdB?=
 =?utf-8?B?VGpRL3VEU0dqYlFXSVppWXJXS3ZFY1Y1UVBBSWFhc1d4QnZiUFFheU1BSTFB?=
 =?utf-8?B?R0QvZlJ6ajEvemFyU0NCdVpBR3JtQXJ0S21Ca3oyM0QyaTYvTy9JVVd5ZGRZ?=
 =?utf-8?B?ejk5QlF6QlB2KzM5RkE5NmRSak1ZUUtDV0FDNDN0YXhwZkdwbGxaWUJ6QlFR?=
 =?utf-8?B?ZmlBa1lzOFMzV2hiZjNaS2FKNjVZMmdxc3BqZUs0QnM4d0Z0L2xIbW41NWFq?=
 =?utf-8?B?SXdza1RURHhqRnZnS1A1eTFNSkhRMEwwWVdBWUhxRUFxRTNPZzd0dldaNjNa?=
 =?utf-8?B?R0V2cE42THFjdWJyQ0xPVEsvVzVqV3V2YnFFeldReHZoV29scEFSRW9tMTNQ?=
 =?utf-8?B?SVVkMkoyUW1iYVpVbVNzZ1NkTlc2NUNLemM2bUZoODNMbFZRaktNMXFMc21s?=
 =?utf-8?B?T0RNcStWb3QwUDF5bGMzZDJyK0cyUlNJZElCaHMzRzNUTjNnSFJqcXBXVTJp?=
 =?utf-8?B?MzhRNTl1TkhheS9WNGhVbzFMQVFQaERudmRBY0wvQWg5L1dmMjJRLzFKT3h1?=
 =?utf-8?B?bkFBY1FJeUJOVmZtb21rYVp3bkpxTnNVMFp6Vzg5UEM1ZVEzUFEwN0pNQnJa?=
 =?utf-8?B?M2FtWTZCODljMTB3U3U4UlZBS0RNeFA4YVZEOERKVys0cE84RDYvdGRYS1JL?=
 =?utf-8?B?VklrKzBmU1ZPU3gzTCt3QTVEMFhLcFkyWWs1MXYxbG16U24xcUFJSFFWOFhY?=
 =?utf-8?B?NFdPV3htTHppTmMyWHVnUFVCemIvSnJQQytWaDJzbWc5bXpXQS80OGxaM3lJ?=
 =?utf-8?B?dW0vZTIwT1hTTVJXejFmZDdiNm1aYU02WGxodTRKcElCeUM1dVlaQ3k2Ri9Y?=
 =?utf-8?B?THRWY25JaklHeVZTakZjMUl3Rk9hWWlsL2tPQ2dQcEZITElub1ExRlhjWWxz?=
 =?utf-8?B?b0hYZWZqNEdpaFhSQU9mb0Rrd3FlRHlvMFR3ZllIdmJGeGhBYSs5WXdmQjky?=
 =?utf-8?B?NnhNZTNxaUowb2dLdm5OZFZydFYvcnU3eGFWdFdXMktuUWRldmZQeEJlUHpO?=
 =?utf-8?B?YS9iZ1BlOWVabWZhZ3FsV3hwRXhNNVRzQnFiTUkzOU1OOUxwOHBua3NDU3d1?=
 =?utf-8?B?QXQ5QUxGUHdEYTR6cGdZL09zeGh0OFhoN1ArbEFESTNMeXBrcTZLTFRwelpJ?=
 =?utf-8?B?VngzK3pXcDhJUTB6a2J5ajh3V3pWd0VhTFBjWVZaRFZwdXBFeHVydlJrNjZa?=
 =?utf-8?B?K1JrSEM3anM1clpRZDVzYTY1Y1VhMUwxdVhlcVMzZzdLb3VHY0IzeUFIamNJ?=
 =?utf-8?B?ME9wNVY4Rkk3NkZOM1JPaGxwbjRwMFNmV0R4SHo1QUVNdW9MSUpZcXdiVTVy?=
 =?utf-8?B?SWhRK3ExSDFKUmtTSUZaekwvV3ZNVHlralFhZVJHYnY5d1Bod2dXdnhHMEV1?=
 =?utf-8?B?STQwZnVwMTRveWhNRloyenFhMzgyQldETGYyaktjTGdHK0R2K2c2NTRUN2Z0?=
 =?utf-8?B?TVhRc1hsbDhoNE9xVTNYbWhOVDdEUFZwekdrWlVLNnVHRXZGYzZiRUxwRTU1?=
 =?utf-8?B?TklWNEZRUnBRQzlGcDZjRURKMnBjRHlhbUlmSVhBNlhsU1p2RTM3bm5QdldX?=
 =?utf-8?B?d3I1bDlZRWF6SG44ZU5vRDhseTE5ZnUzZzl6S3VKamRyY1pLc2M5VjZHQTIw?=
 =?utf-8?B?UC9KN25FTFU2WG85bmxwNnN0TWkwVGI2R0lEK2kvYkxDaWdZVWM5cHVGQ2xi?=
 =?utf-8?B?UllFODJKdCtTeEV2dWdOOGZ3RTUvN1ZXR0tmaVYweWlSc0h5VGJGSDk5U3lO?=
 =?utf-8?B?MVRtL09KdTE3elFmRG1Lb1FZUzZNTHBWYyswbTJhaGJlUU04QnU1akU0NFhK?=
 =?utf-8?B?MDZwYjdWT3ZYK3NkcmFsTjhNa2hQeXlxS3cyRzVIZmhnc0tlbzlvdm1YcU9w?=
 =?utf-8?B?aTBnaW50TXFHdzdOaU5aZUdwbzJsc0RNNDQ5NEdjNjhqa2JzL2RYeFN5cm5L?=
 =?utf-8?B?bUxzbEFHRXJCQXF5KzVOMjFjQ1ZwdVMrVFR5dGhnUlA2bjI0SmRzVHBqTWpx?=
 =?utf-8?B?YjBCSWhQTDEwMXErUjZBS1c5MjlQWHlVZGxjMkV3ZjRMRmtPWVB1UnY2K29h?=
 =?utf-8?B?S3BuMEdNSDZ6YWdHQnpQZ2VaNmhZWmFTeHBvcTU2WUhKZWtDSVVLTjdOWGc3?=
 =?utf-8?B?UDBlNzlCNXBLak5VNVRmNEVoT0w5aUpoeUNWK2ZXVnBUSTE1VW51SWJaeWZT?=
 =?utf-8?B?NXVsbFpzN0JUY0hyS3pzblNqdi9hTU1VaWZCcVpFbHdCait1L0IwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF63C6CDC069C94FB2F63A5406DB7E86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SHMv5poDn5JxTwGoojZKUxpevuUmLfWeXuciOE4CWxt0fxxc/OmRT0WFhU1ORySvLJGgBYSQCXOAP5a39/Qd+Sibb5wFXW16fPcn4GfUL/3gfK2SJp0NWtMDK/TricS0C2xbmkmw23sRYZlBJhKc6SpHIODcn3p8Cqp19dcuvywSq0pJWb1wB53Ze6cdYmvPLEAs+EMuOC0Otx3NLdZMhcJcBFdZLB1L+3xQH/ygUD3QvcQQ6WFiofObZ0TZV6VAK1cs/rJuiJqnfmXvFT+rnJFrDlYzqJsJMzFAjtDZOx6cpOqK7qg08/Bpr5sxN7Vw31SFsoabaiEu0aigROSG7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e374b9-0c25-43a3-f21f-08dec22af202
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:18:03.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oT7gXYrJvEfCnzheNvM0ztrSlGYt94ltKIYljGNiq2/TeqF4MCj/0D4czpT5pOm/oq07D5Zhx/nBTPdWYvOX0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5935
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBFeHRyYWN0IHRoZSBjb2RlIGZvciBnZXR0aW5nL3NldHRpbmcgTVNScyBhbmQgTVNS
IGxpc3RzIHRvIGRlZGljYXRlZA0KPiBoZWxwZXJzIGluIGFudGljaXBhdGlvbiBvZiBtb3Zpbmcg
dGhlIE1TUiBjb2RlIHRvIGEgbmV3IG1zcnMuYy4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdl
IGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vh
bmpjQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRl
bC5jb20+DQoNCj4gLS0tDQo+ICBhcmNoL3g4Ni9rdm0veDg2LmMgfCAxMzUgKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzgg
aW5zZXJ0aW9ucygrKSwgNTcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jDQo+IGluZGV4IDU2Y2NiNmI3N2FiYi4u
NjRjMzY4MGQ4ODliIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rdm0veDg2LmMNCj4gKysrIGIv
YXJjaC94ODYva3ZtL3g4Ni5jDQo+IEBAIC00NjAyLDYgKzQ2MDIsNjEgQEAgc3RhdGljIGludCBr
dm1feDg2X2Rldl9oYXNfYXR0cihzdHJ1Y3Qga3ZtX2RldmljZV9hdHRyICphdHRyKQ0KPiAgCXJl
dHVybiBfX2t2bV94ODZfZGV2X2dldF9hdHRyKGF0dHIsICZ2YWwpOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgaW50IGt2bV9nZXRfbXNyX2luZGV4X2xpc3Qoc3RydWN0IGt2bV9tc3JfbGlzdCBfX3Vz
ZXIgKnVzZXJfbXNyX2xpc3QpDQo+ICt7DQo+ICsJc3RydWN0IGt2bV9tc3JfbGlzdCBtc3JfbGlz
dDsNCj4gKwl1bnNpZ25lZCBpbnQgbjsNCj4gKw0KPiArCWlmIChjb3B5X2Zyb21fdXNlcigmbXNy
X2xpc3QsIHVzZXJfbXNyX2xpc3QsIHNpemVvZihtc3JfbGlzdCkpKQ0KPiArCQlyZXR1cm4gLUVG
QVVMVDsNCj4gKw0KPiArCW4gPSBtc3JfbGlzdC5ubXNyczsNCj4gKwltc3JfbGlzdC5ubXNycyA9
IG51bV9tc3JzX3RvX3NhdmUgKyBudW1fZW11bGF0ZWRfbXNyczsNCj4gKwlpZiAoY29weV90b191
c2VyKHVzZXJfbXNyX2xpc3QsICZtc3JfbGlzdCwgc2l6ZW9mKG1zcl9saXN0KSkpDQo+ICsJCXJl
dHVybiAtRUZBVUxUOw0KPiArDQo+ICsJaWYgKG4gPCBtc3JfbGlzdC5ubXNycykNCj4gKwkJcmV0
dXJuIC1FMkJJRzsNCj4gKw0KPiArCWlmIChjb3B5X3RvX3VzZXIodXNlcl9tc3JfbGlzdC0+aW5k
aWNlcywgJm1zcnNfdG9fc2F2ZSwNCj4gKwkJCQludW1fbXNyc190b19zYXZlICogc2l6ZW9mKHUz
MikpKQ0KDQpOaXQ6IGFwcGFyZW50IG1pc2FsaWduZWQgZnVuY3Rpb24gY2FsbCBhcmd1bWVudC4N
Cg0KPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gKw0KPiArCWlmIChjb3B5X3RvX3VzZXIodXNlcl9t
c3JfbGlzdC0+aW5kaWNlcyArIG51bV9tc3JzX3RvX3NhdmUsDQo+ICsJCQkgJmVtdWxhdGVkX21z
cnMsIG51bV9lbXVsYXRlZF9tc3JzICogc2l6ZW9mKHUzMikpKQ0KPiArCQlyZXR1cm4gLUVGQVVM
VDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGt2bV9nZXRf
ZmVhdHVyZV9tc3JfaW5kZXhfbGlzdChzdHJ1Y3Qga3ZtX21zcl9saXN0IF9fdXNlciAqdXNlcl9t
c3JfbGlzdCkNCj4gK3sNCj4gKwlzdHJ1Y3Qga3ZtX21zcl9saXN0IG1zcl9saXN0Ow0KPiArCXVu
c2lnbmVkIGludCBuOw0KPiArDQo+ICsJaWYgKGNvcHlfZnJvbV91c2VyKCZtc3JfbGlzdCwgdXNl
cl9tc3JfbGlzdCwgc2l6ZW9mKG1zcl9saXN0KSkpDQo+ICsJCXJldHVybiAtRUZBVUxUOw0KPiAr
DQo+ICsJbiA9IG1zcl9saXN0Lm5tc3JzOw0KPiArCW1zcl9saXN0Lm5tc3JzID0gbnVtX21zcl9i
YXNlZF9mZWF0dXJlczsNCj4gKwlpZiAoY29weV90b191c2VyKHVzZXJfbXNyX2xpc3QsICZtc3Jf
bGlzdCwgc2l6ZW9mKG1zcl9saXN0KSkpDQo+ICsJCXJldHVybiAtRUZBVUxUOw0KPiArDQo+ICsJ
aWYgKG4gPCBtc3JfbGlzdC5ubXNycykNCj4gKwkJcmV0dXJuIC1FMkJJRzsNCj4gKw0KPiArCWlm
IChjb3B5X3RvX3VzZXIodXNlcl9tc3JfbGlzdC0+aW5kaWNlcywgJm1zcl9iYXNlZF9mZWF0dXJl
cywNCj4gKwkJCQludW1fbXNyX2Jhc2VkX2ZlYXR1cmVzICogc2l6ZW9mKHUzMikpKQ0KDQpEaXR0
by4NCg==
