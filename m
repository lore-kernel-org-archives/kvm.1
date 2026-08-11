Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651D4B0493;
	Tue, 11 Aug 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408748; cv=fail; b=Daqb07s6d3paGEv0JZ3w+maO7aZ9F1baIkBx8LLt76UTPr82Kqvv0dn1c4u75OGtHZp7vI1yBv2Bl/gkjTdd4ASnuSP9cN8K5jeJ+H5fi0TLhAwMYeMYnT/BhQfDIyLi6onT8AW++M1iKhZEX3refTMpjKu/s6VI/9cF59GL7x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408748; c=relaxed/simple;
	bh=KC3S1LQM44TSPS37OLGewLRzdHNcV3f5effOjMr4zPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UxuYb6fBJTxiMintDNMFAPmyW3muGr/HqWZDDDvROiwLR26f52HUpNjnaLEHsdf9vzOW4V50MelNjnRlWoFE2d9BdzI7QAL/HoYdveXIJHggSwokuXg4rnkUmC+dz2Wr5pMvlj419s65pEExdvhvjy2qGvhOJ2iUudl96FgVQ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rw/mJu3v; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rw/mJu3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786408747; x=1817944747;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KC3S1LQM44TSPS37OLGewLRzdHNcV3f5effOjMr4zPw=;
  b=Rw/mJu3vEFQ1/irUI0jJ+BjZ1f7To1c+NEXJO9Wd+oTVylIkaan5VE/l
   c5tADwFqhZD/6Dfk24UgxCbS+gdeyMZF1NK5/IcEfQQkbxBBO+Y1WrkIl
   1CDxHp+xgwJOFQkwDmxQfPot4FeQ3hQTBW41HCNT+XrgXiOX5HZ9GU0fW
   EjSNgpEzUNyh+IZ4okxEIGcu78IVgY22sq+WYwtIC9ESDRNB0UWpMtB2l
   GjvmfqbbbNKt0utxen/KrLfnDIktcs/yNMkdyCboy5SnuNLkoHvbOMkYv
   kAB2ApH9SxcmSM4EkWxZS1VNvCVfLpr+/GcbUzX4UdUIS61TOZci6Hjqr
   w==;
X-CSE-ConnectionGUID: B0UnmDSoTIubddBDxL2F+Q==
X-CSE-MsgGUID: Mmzh1YcMRKCdOhuKUrYGvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104326379"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104326379"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:39:07 -0700
X-CSE-ConnectionGUID: RBOuk5rxS8quQtkRuA+Vgg==
X-CSE-MsgGUID: rNkMhiiVR9aEnf2BbRPiiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="286595867"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 17:39:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 17:39:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 17:39:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 17:39:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cz1BioL09ztqibUkcCvFnCUu1tCYYSl5w04eBEhnL4UF+8Gdm3yDallCVaDujvnjChAXrtwVdf47su6W7Llv/lSU18RHisfO7vbTRLQUY2Dx/JEI2BCxthnwBAcGUErGF15bzFVITeHjY9LzeeXtSSEuIIVt7csNgTs10dpMeQgrSxSX2QS+J1SKU6UNi5eLXAVxgjPEfuolBLYDcN+vd6xO+aGs5rh6wXbiNrgPNUdgPAH8vWEljJTt+4jY9uqUvx5Fu5isRTDCNgsygZRThKVPIU4hftOT12V106izo3en+ndbn539VDY4scvVIyO03tFCGuP9CJtuUoQFSPSEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KC3S1LQM44TSPS37OLGewLRzdHNcV3f5effOjMr4zPw=;
 b=H7o1dF1GdVb8HQQ3Nwk6gIeZ8g13AMBDxfdK//wky60An2fEz6HNKtFqOoY7+LsytFpGTRW13/Hq761EKtUWOxeeam8AQw95Fu2TDrM26XRm5Dz5Y9dwNobv6GJiKxfUzoVGGsPAkoi4c2kwOtD+pBfRUwgRIOmq1zVPT/uHQBEj4xoKewWlEkXd3OQVTDe8mEjzc0RQLxpOrAPN4eNP9bAelSigKZBgiYIJl27MO1Py2qNMbOyXzO+JAv3s0ffStipE++TA/tQAsT3FU2rHwOuYvSRCj6Wtb9HtAmTNM0z4+TaHc3zHWQemkx4VWDgoeb5nzXeZPCQPDHPVIofsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SJ5PPF75B6D7B42.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::835) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 00:38:57 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 00:38:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Topic: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
Thread-Index: AQHdKLszJKJ95KF+vUOi4YjlC1BNl7aYAh4A
Date: Tue, 11 Aug 2026 00:38:57 +0000
Message-ID: <5dfed336a46329ba39922dcb3a8723116dae9ae4.camel@intel.com>
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
	 <20260810112200.2326727-3-xiaoyao.li@intel.com>
In-Reply-To: <20260810112200.2326727-3-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SJ5PPF75B6D7B42:EE_
x-ms-office365-filtering-correlation-id: 5732820b-6b86-4011-92ab-08def740edde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: MRAlaz6E7+y+kx2awJRv757zuIztH0UdLwIgNwfO+H0HoLceXiOesJ+Ny0m2c7xIOc74dDFJQFJhPDInq4jJ3qioCeARoLKlORVX7OPOVR+veU+Ro5hfgn9Vl4eaqhYc7DHn9j9P0w6pTUEV+rikCeFDv0I26ZD7rOXXeyFptqMAJIWKYMqzBw0iWRhEZH9skfI69rqWOQ9aBOIg2gg09FF7GzLeckJUz5FUZhddm49jsl8l7B3TJCIHU480ZisbfHRrEPzhjKC0nX9S2prFfyvxaQXoj34THhT7ickX+NNMBYZJEbFHCZ0BUom6vcN0XB/KSdlsO0UedkaiCAYHVH8TYeCf+ndfRlNtgnXjt3icKZF8w/HGxIi2WtQqCyMblIQc/hEG5Neabf0GZbjDDdHMlww9QNSe0R41mwMSGzyL0FMsRvbKwQ5qdblpgYdqJJCZo0ZZ8ZsA4HXsZH6WX2t32cT7vkYHkZtrKsxk8OjxIoleT1TwWR1rr6Y+0BQjvyfMTUwUNOKGvxMfsWVw0kqqT89GLWx7nkKIhVb4d4R+LMCzzt8jclGpI0XXhwwaO/6UnGXDKTC1YkQZjpoXjBXYhkZQfzU3D8zCPjBF1m+OwbhVUqKmbyy5Y5FUiijHhGbFXmVPGsFaFhBgMtieXApKK7lTJJcgMkId9q3qgzkf9bi2RtXTExG9xRNnwAKDjn1ee6P/bRUSQtzLJy3gzrS/3VllR1hQE+w6bliqks4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFQQXlNRFZDdGd3Z1VPVWRVakVLbys2RGNRUlZlS2Z6R2NxcFJ6bW0veHlq?=
 =?utf-8?B?TWgwcUw2OFpsQU1WZFFSQk0zWW5RaEdZR0pwejR0dUhldDB4QWcxOUh5QmYw?=
 =?utf-8?B?b0FPT0o2YkxSaGJpZitOcEJRMmVLREwrc2wvZ09OUHFiOUlObUdLVGdoandw?=
 =?utf-8?B?dkJrcTZRWVRpMU1HdTNiYk5JeE54NEhjSEFEa0lKT29aOXY4TERESERlODRZ?=
 =?utf-8?B?bmpSTS8wRENxejVGV3dRY0tHR21NT1JrRnJrWHp0SksxREpLQjEvZnZpb3V5?=
 =?utf-8?B?VUVEUnIvMTZhQzFXNkRnaC9HN1JNb2s2R3czSlBYVzVjRytoUU5hYXF5VG1a?=
 =?utf-8?B?dXE1OVFma3gxMm53Zmcxd2oxNUZFcUtjTCtpTitaOHdxdEpxVG5NdGpSVW9a?=
 =?utf-8?B?cUEwMk1Nd3JlTm5jd3FhRFlhdkJnYmR3SFlFLzFsemZZd3lkWGNBZXFFSk5E?=
 =?utf-8?B?ZWs2ci80TVh2TnQ3OHpVVXlxNEwzWTF6bnF4cEJxY0Zsc01lY0JnLzE0elll?=
 =?utf-8?B?NDdEdXNBcy9jeTlXejZaWnRxWXFGUkhmVkJxbDgxREFvbG83ek1ka1RaZDgv?=
 =?utf-8?B?Zk8zQW1HbVB4eDMzYXp1d0dHUHFndnRRckVHM1huOVlML2U2S0Z0U01tdXRK?=
 =?utf-8?B?bWhWNDVjbGFOa0oxcS85OGtzVktBUXJjdEh0eTIzbEYzemMzTnhIanhNY0dj?=
 =?utf-8?B?S21CNmJTVm9ZWEFsR0xMaUo0R3RBdGd3Q0lCeUJ3RHA5Rk44RWZSdlBMZ3or?=
 =?utf-8?B?MTQxYi9EWTltTkZodCtzZDRCbnpEa3FiQjZGYUxHcGVrOVlFMG0vd1FudnJu?=
 =?utf-8?B?OG5zcEV4Z3hrZjVZMGc3L1A5ZDhTTWlRNTBiU09Va3U5OWZpbUtFeTN1YStU?=
 =?utf-8?B?YjlMY1FDNlRpTS81QjZHTUxudVUxV0twVzRaR2lENENuQlZoVVFqSE5RR3FV?=
 =?utf-8?B?ejlKc1AydlhEQXp3UVZxTnkwYWNDWS96V0piTVUzMDByQnF0Q3FBeGpvTmlK?=
 =?utf-8?B?aEFpTnhjWWhSL2ZhcGNOdkNpWVc0Y3RmblhwZTN1aTJVNXNKUDdqNURjQmdD?=
 =?utf-8?B?aDl3cTVETjlmV2Vta09iUmlmYittWHlIbFhhYlVxRzFwQ21NbXViSEQ2RE5y?=
 =?utf-8?B?blZOTHNYWncxeFkxS3ErRTBrWFlUZ2xJK09rdE93bHZWYkR1TkI0MDJvdU4r?=
 =?utf-8?B?Y3hSSjNoeG9rYm9JNktzWWI4b1U3M3dGeGxlMnZkbkhUWitzQWxGeHVHZHlG?=
 =?utf-8?B?bUZGVDhSdW5mZzh1QmU5UkFRamkzS2pQNklzZHNTMHdRUndsdHE0VjdLeVBp?=
 =?utf-8?B?VFpnR29hbzNwZnZUVkRyNVFoamVYalJJSjVRaG5DUkJBUzNIQm5mT1MzK2xH?=
 =?utf-8?B?c0pKc2ZzV1NKZWZ4MGtMdVJQRklYc0JiR0V4T3Ryb215VjZETVJueS96Mmwv?=
 =?utf-8?B?WTdOK0lmdFE5YnVaK3BaS05nSTFqOC83TlhGZFU1c1o3T3pUb2NTWW5wWlFY?=
 =?utf-8?B?K0dLdi9RYnRXaEd2ZGNZOXlDK0Z1SGg3KzRlQklqdnlUMGhWQ0pSeFppWm4v?=
 =?utf-8?B?WDF3L0N6aGY4RzlIbFZIS2hvdDlsR1pETDgzSzlrVnZhOGt4Q0VGWm5yUTlX?=
 =?utf-8?B?RnFuMDd1WE12ZVdwSVlWRjgrdkJocFNoaFY3Q2U5RDFncUdrMHZPWUZVakps?=
 =?utf-8?B?UHdXOXNybHZTVnI5VU5IaitqRE51N0FTV1ZNd3VycFA4S2l0azdmcDFHdE8w?=
 =?utf-8?B?cFBzT3dGTFc4cURaSi8yYW1XQStoZmRKc1graUltRCt0bXZQR0FvTGdIdWxt?=
 =?utf-8?B?UnI2RkxEVnFjMzJVRzRFR0lHVWNRR1NEL0dwNGxDcStiVmJwK2o1eUorRGVh?=
 =?utf-8?B?dWpOZ0xUNDdkdnA5ODRaY1RIcC9CSUdmNVFDWHZBSUZXcFdGRTJYeHdUa0py?=
 =?utf-8?B?cDhBeTkzZmt2N2NOWDRTK25aYzVpcnJ6WGdMUVd2TThUYVRRdjZQOVQyWDJX?=
 =?utf-8?B?OVVtZHkwalNrRFRvTzJvMng2bUpDTGhXUDFiNzUxbjIwNFg0ODJETENIdk5U?=
 =?utf-8?B?TDhJMjhTVjIwVnY5MTJLNEJKMkF2TW84MlFXZVowOTB4SndlL1AvRm9nR3l4?=
 =?utf-8?B?M3p1L3BRN3ZXemxQaU0zNm5mV1hSMEE1allxdGJzenNLQ3huSWRWVFRPTWN3?=
 =?utf-8?B?c3BEdjdiY0xLVW9VZGdCRnFxaU9IQmU3cHZzdTd3dkNzWHlmdSsxLzl6aXRq?=
 =?utf-8?B?amRnSnAveExTcTRDNGJKdDlFNFptZGtGbkNTY2dZTk9XUVVMMk0wcTkraURy?=
 =?utf-8?B?dGU1NFVzR1AwbnB3WkdTUjlvMnFpYlcxT2h1VktvM2lENXRldEFkSVh1SEJl?=
 =?utf-8?Q?eQ+hTe/6C/KLS1RE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9703909E265D0E4DB9A0AAF3061B0D45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XBQ6KnWJze9emmN8ykKWEhWwA9+AvrHqQsT6uo6rjyNFCIlSeclok8Wr8chKn+Hd8ZYjBJApvbPKKTq4ky2b0emqIQgrJhcWYY8GT0OLvAfJsNkGNvdMJGCx6dypiv7cFu0DPUhNLV3i4OKtWJL+YkFBh+GzDmIW1ZLuo7S0af7ic7aPVntPsCaGkjvPe+pV7zm2XtcGP6f2QB2lOpGQfOdiLfvr37wlRVWFpc2n8/+ldi3M54mtY/9YtR5fys8mckaFIW1vCJFZfAmhrIMjnKfguWtiLdTBew6R0myZkuPABzJxqaKyd6LC2y1InoD0uLgYVo64eMzJJJUP4NK45A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5732820b-6b86-4011-92ab-08def740edde
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 00:38:57.3883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpShKlaxDk3YzuTgR3lJtJw9wFWigc4cRWFAxhLIpofjwGzrPJSY1CsvtumV9RijXtTjSqdaIRSLasofnWBTClLUWzCicz5zcb784gxWoY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75B6D7B42
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE5OjIxICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBH
ZXQgYW5kIGNoZWNrIHRoZSBleGl0IHJlYXNvbiBmcm9tIHRoZSBsb3cgMTYgYml0cyBvZiB2cF9l
bnRlcl9yZXQsIGFuZA0KPiBzdG9yZSB0aGUgc3ludGhlc2l6ZWQvdHJhbnNmb3JtZWQgZXhpdCBy
ZWFzb24gaW4gdGhlICJiYXNpYyIgZmllbGQuDQo+IA0KPiBTb21lIGJpdHMgaW4gdGhlIHVwcGVy
IDE2IGJpdHMgaW4gdGhlIGV4aXQgcmVhc29uIGhhdmUgdGhlaXIgb3duIG1lYW5pbmdzDQo+IGFu
ZCB0aGV5IG1pZ2h0IGJlIDEuICBXaGVuIGhhbmRsaW5nIHRoZSBleGl0IHJlYXNvbiwgb25seSBk
byBoYW5kbGluZyBvbg0KPiB0aGUgbG93ZXIgMTYgYml0cyBhbmQga2VlcCB0aGUgdXBwZXIgMTYg
Yml0cyB1bmNoYW5nZWQuICBUaGlzIGNoYW5nZQ0KPiBhbHNvIGhlbHBzIHJlbW92ZSB0aGUgYWRk
aXRpb25hbCBjaGVjayBpbiB0ZHhfZmFpbGVkX3ZtZW50cnkoKS4NCj4gDQo+IE5vdGUsIGR1ZSB0
byB0aGUgc3ludGhlc2l6ZWQgaW52YWxpZCBleGl0IHJlYXNvbiwgLTEsIGlzIGNoYW5nZWQgdG8N
Cj4gYXNzaWduZWQgdG8gdGhlICJiYXNpYyIgZmllbGQsIGFkanVzdCB0aGUgY2hlY2tpbmcgaW4g
dGR4X2dldF9leGl0X2luZm8oKQ0KPiBhY2NvcmRpbmdseS4NCj4gDQo+IEZpeGVzOiAwOTViNzFh
MDNmNDkgKCJLVk06IFREWDogQWRkIGEgcGxhY2UgaG9sZGVyIHRvIGhhbmRsZSBURFggVk0gZXhp
dCIpDQo+IEZpeGVzOiBjNDI4NTZhZjhmNzAgKCJLVk06IFREWDogQWRkIGEgcGxhY2UgaG9sZGVy
IGZvciBoYW5kbGVyIG9mIFREWCBoeXBlcmNhbGxzIChUREcuVlAuVk1DQUxMKSIpDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW95YW8gTGkgPHhpYW95
YW8ubGlAaW50ZWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gIC0gbmV3IHBhdGNo
DQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL3ZteC90ZHguYyB8IDM1ICsrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC90ZHgu
YyBiL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gaW5kZXggNzMzOGFjMGFmNjkzLi5hODk4ODVk
NTUwYzkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdGR4LmMNCj4gKysrIGIvYXJj
aC94ODYva3ZtL3ZteC90ZHguYw0KPiBAQCAtOTIxLDEwICs5MjEsMTAgQEAgc3RhdGljIF9fYWx3
YXlzX2lubGluZSB1MzIgdGRjYWxsX3RvX3ZteF9leGl0X3JlYXNvbihzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpDQo+ICAJcmV0dXJuIEVYSVRfUkVBU09OX1REQ0FMTDsNCj4gIH0NCj4gIA0KPiAtc3Rh
dGljIF9fYWx3YXlzX2lubGluZSB1MzIgdGR4X3RvX3ZteF9leGl0X3JlYXNvbihzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUpDQo+ICtzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuaW9uIHZteF9leGl0X3Jl
YXNvbiB0ZHhfdG9fdm14X2V4aXRfcmVhc29uKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIHsN
Cj4gIAlzdHJ1Y3QgdmNwdV90ZHggKnRkeCA9IHRvX3RkeCh2Y3B1KTsNCj4gLQl1MzIgZXhpdF9y
ZWFzb247DQo+ICsJdW5pb24gdm14X2V4aXRfcmVhc29uIGV4aXRfcmVhc29uOw0KPiAgDQo+ICAJ
c3dpdGNoICh0ZHgtPnZwX2VudGVyX3JldCAmIFREWF9TRUFNQ0FMTF9TVEFUVVNfTUFTSykgew0K
PiAgCWNhc2UgVERYX1NVQ0NFU1M6DQo+IEBAIC05MzQsMjMgKzkzNCwzMyBAQCBzdGF0aWMgX19h
bHdheXNfaW5saW5lIHUzMiB0ZHhfdG9fdm14X2V4aXRfcmVhc29uKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkNCj4gIAljYXNlIFREWF9OT05fUkVDT1ZFUkFCTEVfVERfV1JPTkdfQVBJQ19NT0RFOg0K
PiAgCQlicmVhazsNCj4gIAlkZWZhdWx0Og0KPiAtCQlyZXR1cm4gLTF1Ow0KPiArCQkvKg0KPiAr
CQkgKiBTeW50aGVzaXplIGFuIGludmFsaWQgYm9ndXMgRXhpdCBSZWFzb24sIGFzIHRoZSBURFgt
TW9kdWxlDQoNCkkgdGhpbmsgdGhpcyBibHVyYiBjYW1lIGZyb20gU2VhbiwgYnV0IGNhbiB3ZSBz
dGFuZGFyZGl6ZSBvbiAiVERYIG1vZHVsZSI/IFRoZQ0KY29kZSBjdXJyZW50bHkgdXNlcyAiVERY
IG1vZHVsZSIgYW5kICJURFgtbW9kdWxlIiBhbmQgIlREWC1tb2R1bGUiIHVzZWQgbXVjaA0KbGVz
cy4gSSBhbHNvIGRvbid0IHNlZSB3aHkgaXQgbmVlZHMgdGhlICItIi4NCg0KPiArCQkgKiBuZXZl
ciBhdHRlbXB0ZWQgdG8gcnVuIHRoZSB2Q1BVLCBpLmUuIHRoZSBFeGl0IFJlYXNvbiBpcw0KPiAr
CQkgKiB1bmRlZmluZWQsIGJ1dCB0aGlzIGlzIE5PVCBhIGZhaWxlZCBWTS1FbnRlci4NCj4gKwkJ
ICovDQo+ICsJCXJldHVybiAodW5pb24gdm14X2V4aXRfcmVhc29uKSB7DQo+ICsJCQkuYmFzaWMg
PSAtMSwNCj4gKwkJfTsNCj4gIAl9DQo+ICANCj4gLQlleGl0X3JlYXNvbiA9IHRkeC0+dnBfZW50
ZXJfcmV0Ow0KPiArCWV4aXRfcmVhc29uLmZ1bGwgPSAodTMyKXRkeC0+dnBfZW50ZXJfcmV0Ow0K
PiAgDQo+IC0Jc3dpdGNoIChleGl0X3JlYXNvbikgew0KPiArCXN3aXRjaCAoZXhpdF9yZWFzb24u
YmFzaWMpIHsNCj4gIAljYXNlIEVYSVRfUkVBU09OX1REQ0FMTDoNCj4gIAkJaWYgKHRkdm1jYWxs
X2V4aXRfdHlwZSh2Y3B1KSkNCj4gLQkJCXJldHVybiBFWElUX1JFQVNPTl9WTUNBTEw7DQo+IC0N
Cj4gLQkJcmV0dXJuIHRkY2FsbF90b192bXhfZXhpdF9yZWFzb24odmNwdSk7DQo+ICsJCQlleGl0
X3JlYXNvbi5iYXNpYyA9IEVYSVRfUkVBU09OX1ZNQ0FMTDsNCj4gKwkJZWxzZQ0KPiArCQkJZXhp
dF9yZWFzb24uYmFzaWMgPSB0ZGNhbGxfdG9fdm14X2V4aXRfcmVhc29uKHZjcHUpOw0KPiArCQli
cmVhazsNCj4gIAljYXNlIEVYSVRfUkVBU09OX0VQVF9NSVNDT05GSUc6DQo+ICAJCS8qDQo+ICAJ
CSAqIERlZmVyIEtWTV9CVUdfT04oKSB1bnRpbCB0ZHhfaGFuZGxlX2V4aXQoKSBiZWNhdXNlIHRo
aXMgaXMgaW4NCj4gIAkJICogbm9uLWluc3RydW1lbnRhYmxlIGNvZGUgd2l0aCBpbnRlcnJ1cHRz
IGRpc2FibGVkLg0KPiAgCQkgKi8NCj4gLQkJcmV0dXJuIC0xdTsNCj4gKwkJcmV0dXJuICh1bmlv
biB2bXhfZXhpdF9yZWFzb24pIHsNCj4gKwkJCS5iYXNpYyA9IC0xLA0KPiArCQl9Ow0KDQpXZSBj
b3VsZCBtYWtlIHRoaXMgcmV0dXJuIGluc3RlYWQgYmUgYSBnb3RvIGVycjsgdGhhdCByZXR1cm5z
IHRoaXMuIEJvbnVzIGlzIHRoZQ0KY29tbWVudCBvbiB0aGUgb3RoZXIgb25lIGNhbiBjb3ZlciB0
aGVtIGJvdGguIFdoYXQgZG8geW91IHRoaW5rPw0KDQo+ICAJZGVmYXVsdDoNCj4gIAkJYnJlYWs7
DQo+ICAJfQ0KPiBAQCAtOTY3LDcgKzk3Nyw3IEBAIHN0YXRpYyBub2luc3RyIHZvaWQgdGR4X3Zj
cHVfZW50ZXJfZXhpdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICANCj4gIAl0ZHgtPnZwX2Vu
dGVyX3JldCA9IHRkaF92cF9lbnRlcigmdGR4LT52cCwgJnRkeC0+dnBfZW50ZXJfYXJncyk7DQo+
ICANCj4gLQl2dC0+ZXhpdF9yZWFzb24uZnVsbCA9IHRkeF90b192bXhfZXhpdF9yZWFzb24odmNw
dSk7DQo+ICsJdnQtPmV4aXRfcmVhc29uID0gdGR4X3RvX3ZteF9leGl0X3JlYXNvbih2Y3B1KTsN
Cj4gIA0KPiAgCXZ0LT5leGl0X3F1YWxpZmljYXRpb24gPSB0ZHgtPnZwX2VudGVyX2FyZ3MucmN4
Ow0KPiAgCXRkeC0+ZXh0X2V4aXRfcXVhbGlmaWNhdGlvbiA9IHRkeC0+dnBfZW50ZXJfYXJncy5y
ZHg7DQo+IEBAIC05ODEsOCArOTkxLDcgQEAgc3RhdGljIG5vaW5zdHIgdm9pZCB0ZHhfdmNwdV9l
bnRlcl9leGl0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIA0KPiAgc3RhdGljIGJvb2wgdGR4
X2ZhaWxlZF92bWVudHJ5KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4gIHsNCj4gLQlyZXR1cm4g
dm14X2dldF9leGl0X3JlYXNvbih2Y3B1KS5mYWlsZWRfdm1lbnRyeSAmJg0KPiAtCSAgICAgICB2
bXhfZ2V0X2V4aXRfcmVhc29uKHZjcHUpLmZ1bGwgIT0gLTF1Ow0KPiArCXJldHVybiB2bXhfZ2V0
X2V4aXRfcmVhc29uKHZjcHUpLmZhaWxlZF92bWVudHJ5Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMg
ZmFzdHBhdGhfdCB0ZHhfZXhpdF9oYW5kbGVyc19mYXN0cGF0aChzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUpDQo+IEBAIC0yMTQ0LDcgKzIxNTMsNyBAQCB2b2lkIHRkeF9nZXRfZXhpdF9pbmZvKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwgdTMyICpyZWFzb24sDQo+ICAJc3RydWN0IHZjcHVfdGR4ICp0ZHgg
PSB0b190ZHgodmNwdSk7DQo+ICANCj4gIAkqcmVhc29uID0gdGR4LT52dC5leGl0X3JlYXNvbi5m
dWxsOw0KPiAtCWlmICgqcmVhc29uICE9IC0xdSkgew0KPiArCWlmICh0ZHgtPnZ0LmV4aXRfcmVh
c29uLmJhc2ljICE9IC0xKSB7DQo+ICAJCSppbmZvMSA9IHZteF9nZXRfZXhpdF9xdWFsKHZjcHUp
Ow0KPiAgCQkqaW5mbzIgPSB0ZHgtPmV4dF9leGl0X3F1YWxpZmljYXRpb247DQo+ICAJCSppbnRy
X2luZm8gPSB2bXhfZ2V0X2ludHJfaW5mbyh2Y3B1KTsNCg0K
