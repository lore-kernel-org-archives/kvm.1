Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF33A4F5B
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350911; cv=fail; b=Pp379c9UtOoOtR2stKribv2j0cT3HXIqfQqxV/F5IXYE+LojUdxaMWexbrgy7w12upCP1bjhYyXmlXbw/+WNuozXYeuNdxXGdyeRk+P6BSh8yAhnG+pXtHPpyMoE2egi/+Fr8DDyYMcAneTo6A63woOZM9wvfhxf0yKPFdnWdaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350911; c=relaxed/simple;
	bh=luYWobh7J6ROWZBKsFMfiUN6ZCz70gW3UE3MA/4i1rc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I++4ONNEEM9j3Imf+mRzvUQ2+y4ufYKrJWuBvenjsdPSt+li4cy0xnAnp1OpFltK8b3p76blO1fMv3KXASLdUniIzECMa0Lw5dY3HCKK67LyzwzaOZF2e/ZaSMtji9oyd5TjDyEvZHqEczZw40PatbYxdfv8oNVD6MwhKuL8TT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETpWMzsp; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETpWMzsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350910; x=1817886910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=luYWobh7J6ROWZBKsFMfiUN6ZCz70gW3UE3MA/4i1rc=;
  b=ETpWMzsppJXp3JUz+UQG1ll8syx8ttXX/ITG6xCD5Qs8rhLwZlFBp31c
   YHc8+bgyY+K3ZzVn5VReQRYodVbcMJsFQ2xn8zJlxfnLFyYPibStG1udp
   UCHgmPY4XvsWnlFqKNjPZtU2Vbz8ekUc9DAu0Q5YQyAvLwrKDWfnSoV5f
   Jw462aCerstAosNkfKCa2i0HqV2luHjZIhwJN3EOKDYtrU9JHmLCfE/5a
   0RT9gpt0UgCwIovO6QwhsWh7WV6Dy9LNrXA8niVj21LRm2JEapvRTZKOS
   r8aogXoUiYsi6pNTGEqcVIAYxgXYWlKHXa+s4lL4RUAxJaxXwLFLOQ83N
   Q==;
X-CSE-ConnectionGUID: vbg2wAN4SvKLh6/KWCT/ew==
X-CSE-MsgGUID: PFSSPzOySJeUiEI6VXc5TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98372272"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98372272"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:34:54 -0700
X-CSE-ConnectionGUID: jOQARQWlQ0iZ98VZZ5Jq+g==
X-CSE-MsgGUID: 3io8B7eZQTajpdjmLlFboA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="301200478"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:34:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:34:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 01:34:50 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 01:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAadwRlmtq6Zn234/+T5Jt9xN9bPUK9ty86mq0jqkd2mIMV59Toh57gWLPlE5EEpZKLxIlx2YdQqiINSxoE9HZMsDD40b5Kk2LZbuhT8Re7E4xusOVWq0VfFlQLSJ20Z+AYopeyuYcO1qZVs2YyOOhRp0pBI7NJLnvIXrRYOqTNTRRvDkZy8pHJp0gw464JNEt2YrjDQWSwwTx4d5EFieRcOpE/b4GBl4BUNLLVCPJ2OAtZRIDl4guHjEJPn1uJ9Dyki06INc7lolcmxkiUFoNxariG5a6HteWAJ8csUeTqkJRZZzRJRxfbg/dn3FpeaH7SvateBCiLSvfPoVJApeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luYWobh7J6ROWZBKsFMfiUN6ZCz70gW3UE3MA/4i1rc=;
 b=Lz8cv196SbP2n/MxnKBYKm0grIJpu+b9hOJWXDp3bpMfco8S/jW5b98aEzIjNJrpFyeFcdtjuOBNcg12ZrMoQtdqSbPBwFr7gYQpr/wPO7x7hEpr5DoQ7k0Zzgh7LtxGGLEC13cLh4GHGpARS4DMUPIfkCLFSwxrB2dey+Fwicd+fUgF1e54Pz8wZ9rl5nsx29aa1u+Vch+Um/XcPXyVjcFE4BFkwAX9kpp7FPN/UFPeJWfrtbc8OloruZCMgzLn6Ommi/9JByiCM7jMRzIBFrhY0Pn/4cGq4UFvhTSnhpQ9teqHf/CcapmbT+DZ1Ar1JpbrypFTRQIbUcqHa2fDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:34:47 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:34:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: x86: ioapic: Update state only after successful
 delivery
Thread-Topic: [PATCH 1/2] KVM: x86: ioapic: Update state only after successful
 delivery
Thread-Index: AQHdKI/8nPQ8wShRO06vxp/PlcPoqbaW9Q+A
Date: Mon, 10 Aug 2026 08:34:47 +0000
Message-ID: <c9193d0a13e39fc385699772ba58b457e41ccbac.camel@intel.com>
References: <anls-aUppuiFolpS@192.168.1.215>
In-Reply-To: <anls-aUppuiFolpS@192.168.1.215>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|SN7PR11MB6601:EE_
x-ms-office365-filtering-correlation-id: 1c1c817a-7357-419a-731a-08def6ba3c74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|38070700021|6133799003|10067099003;
x-microsoft-antispam-message-info: 6xBiP+z421HiudgTY0XQYrs8+EzAFtzbyGWpzWikfWOW8LR8esUlUmx7nAyDKqp2eKmgVTHcd5BHPN5SQ2pbEoyM9rmThpgboahSHdco10gS7jRBlvIZmfpmqPMB6uicoFaRJPrQyiOGA6KtnAb7RgD1xiJTH8GerYT8fg+F6RCG064mCZwWBr2apvvTlpNnt0A+0brGKjsqN+gp4BKw4dvY9Ub3cjmXlgntuf6hK1ILS2XhPW6nUmNdxpS4eZFTVM9jtnJsziEqf33bMOVOJdlrprHuqZX8GaZQgmZ7q+M1MnNFcid16p7T5g4V72ZyTP47LsUrdNldkzQQypQg06dMh7UXeobl8OgMndsnZbZIPpCBN8qEmtj9YeDUu+1AtBRNaB0JCNjCfgYpawuCFKNXMz2+SRKyFHFDrjM5RcWPbPlyM59w2r2rB1fIVK8qmJxsxZ8rD7p2ioTH2qYWHWrtXo1yuTmmjZcs2IJvH/0BrcwY6HP1C1sWOwyRcrjbDwBitPhof2A1EpjSb4CgI0AqA4NsL7fbg2WRS4KQMJBSqx5o9WL6Midi93EeU3soCKRyZNgFGQPEqaV6KDDv4njd10L6z5DrQ4E7YvZRn55J8xW3pI5RniZRLaYEGVF4irXSZs/iMVxFMXTsTzgcYxs1mZXwA1VyjMN7aoMt5aq5Z5tQcLq91vHK6/2MgqxO8LIvf4d7SDZVRz/RIyZsoSxTE7J5Hu62DCw58mClj6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjJQZVRpTHpDTys4QVZMY3pIZTVuY2FOVlJMdXBhTkd4RnVMKzlSUkQ4WE1h?=
 =?utf-8?B?VThLb1NIU2tEeThsQlhwSjNQdUZIMVlNbGR3c1p1L1ROMjRiVkxXcmlsZSta?=
 =?utf-8?B?TERCNmtjK050TFpkcHJhTldqUm9nWmEvMFB4aXRXVndWQzhrbEo0a01XSVFX?=
 =?utf-8?B?VWl3elErekZOaE51QWxqQUU2V2ltZXNYdWEvS2hFV09wakxmOVRsVGszM0Mz?=
 =?utf-8?B?YW1kcVkxUUlrNGs4WWpIWiszdXoyU2xRZXBySW4xMFhpS3BqZGoyNU9FVzhB?=
 =?utf-8?B?cldDS0Q1Q1paa1dIL0NOR2tuRkl5UGQ5YkFOVmZ0cWdGelBlZ3RGSTN5OGRu?=
 =?utf-8?B?N2FlVTQrOUsvN25TMU5VcFJrRTd3NmRYM1F0N0E3WjBRMi83NTlJYWVuamFV?=
 =?utf-8?B?WUp0WWRvdzNoelZxWlBDWmIwUDJOSmhGajdFZGFkVlo0cGwxM05mc2hDNmQ4?=
 =?utf-8?B?Z0pVWXcvaHhUQzBqMjFJdzV6VDkwbk1OV21maFRwVzdaVGJBNHdCRVJTSjZZ?=
 =?utf-8?B?dzR3UFpUaXdaeDJnNUpzVkphSmZVZzRrY0NqMGovUE9zdkRaeWJDdDhyOE9q?=
 =?utf-8?B?U3pMZm85T1gzejlnWG0weG12ekgxRDZacEo4Qkc5NDNNaXo1aXhhYzIxVE9L?=
 =?utf-8?B?R0cvYzFqOXFycTVYQWlha25vN2ZTdTJkYmVvak1UTWtqZ0VDaUF3R2pCc0NJ?=
 =?utf-8?B?Z2lEMU54NlU4MVZ3eDI1aEFQSVp1TlYxTVM0eUV4dEZ6bnVIQy9LNlI3dDZ2?=
 =?utf-8?B?Wm5vNEQzcEFJN0U1aENJVkoralBSbndqNlJxVHdsRW5iYmlkTXJlMUdoTjhO?=
 =?utf-8?B?cGF0MGlUNVBUVzVVb2lYUFZyRmdyUk56RUpDazhOL3FieWIyVUdBYjR0WlJB?=
 =?utf-8?B?ZUM1amI3Y1FEQ1cvNTI4TlppMUNvWW5LLy9Jd1dJZTIrcTg0bXcwSmViQW5Q?=
 =?utf-8?B?RVl6aWttNUp0eEJhQTF0a1l2Z2hFSEFVd0hnazdBZ09ab2IvdXdmRDB1VDNG?=
 =?utf-8?B?SFZQVWNlZTl1SzNHSHNWSXRYdmU3MGs5d3UyMTQ0cTBIVE1OUkhoWTBZZjRW?=
 =?utf-8?B?dmwzelMreGFWdXZxOUdySVBaK2M5UUhBbitBSk03aC8waTJjQ1BZaHRxSjhL?=
 =?utf-8?B?V3NvMmt0SzVLUmREeTdrYkZoOGJGTUFjYjBIN2xrTTJQaVVuc3hRWWZURG5u?=
 =?utf-8?B?NjgyNG51OFNSYm5ENkpGZGpKUm1WQ1o5QUJRUlhZUVVmK0VxOUpLVUlaUkZs?=
 =?utf-8?B?UTRjOHVrRmpiSFdpNXVwSXR3NkxELzdxdzR6dzVOMkoycEFMbHQrOE9DQWRt?=
 =?utf-8?B?b3hXMDdKS01zVmd0VGhRVGM1MWdhNWh4V2NZSkpXT1FUSm1QVkQ2T0FyV2lr?=
 =?utf-8?B?UXpZcDNORnFmNHltTTBxckJiVHdDR1R0Mi9QNU5pWkx1Z3MzUDFYNllGV2lz?=
 =?utf-8?B?YnJWZXNkQXMzMUFncE9HTE9NaGRlQ3Y5MlkvWmxKVDNpRnhmampOaXpSVm5P?=
 =?utf-8?B?bnJ4YlFzaGlnRWhsVXlMenZQWHU3RkhDcWo1Yitqc1dwYkptWVRnblM5bzJ2?=
 =?utf-8?B?SldpcjZudE9tcGJMWlIzNlNTTE5LcEptV1JQTFJDWFN0SDNuMm1BSzRULzFa?=
 =?utf-8?B?NDdwY1J0WkpadzhEN1I0eU1WVU1aSndmQlEzM2oyc3NQS3VXanpmTHlKOVVi?=
 =?utf-8?B?UkdINVR5a3dYRUlxdVNpeDdBL3Y2em1MRmVzdk4xZnB0ZnhhME56SlRJRmtY?=
 =?utf-8?B?cW5oMWNrSngvWlovNEx6ZUdQaXh3SlNydk9uZXVFczlEZlBIL3ljQ0UwM09M?=
 =?utf-8?B?Ylo5Rzl1K0dCK3lTdmNkSnluR3ZHMVQ4MWp1UFNDQThXcFdKVHdLS3JSZXZa?=
 =?utf-8?B?Sytta2dES2RGMSsrYkQxUHpwK1dwQ0xXNGp1T2dBck5MWFNBbGxqR1o5VDBa?=
 =?utf-8?B?d1pHOS9nV3NLRVZoazJ4eFhGckw4Z0tLQmoxUHZDN1V1aS9ncHBQemNCT2tG?=
 =?utf-8?B?eEx6T0tpQkZlb0U4eExxblNsTEFzdkdYVzE4SlJFYTBLR0FFYjIyN3BNWjd6?=
 =?utf-8?B?VS9JU1BRekFVTUJhU01EeFMvamliYzg4U0dkLzUzNlBUQUpTVUVHM2FJU1RF?=
 =?utf-8?B?L0l3YzBWdC9nMzBpTEc0dUpDSnBFR1YySEtzNDhTbWZWUjJOaExPS3k0bzll?=
 =?utf-8?B?a3BSTzIzV1RONlgzVTZPb3h3KzV5UHE3NHZsNVZobWVEWCtnT2lJYW8wdXdj?=
 =?utf-8?B?Q1dOenlWRmFQclJYZFpCMnE2MVlnZmFFV0J5R0FwU0Q5RFhCTEl4akZNOVAz?=
 =?utf-8?B?azdLZGJIcVZtcUFiZkxmTXpaNGgzRUVFcnNmTmxjWE5KUUJhRmhPdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C05FD9A36B5DD245881E913AD3CC2A2F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BqguUixTgi9CKIyz8TDr80rfC+OqyuMiDeL6EowxPmNRQ+Cn4zd6Lg+SE4ABTpYpR3iYLL+3m8odfYN3LxLt9r9y6BF7s/wd0w8fVoaGD/Qaa/J33PIKmnjGuPgF20iQERjBunv5vMHtxSLO08QsRLMozDWqpJAvsmKUhj4Q+cUsjyWOaOlSvbOP7aMWuvfDL8K3mV2nlWkjhUMA7X18nDhgu9edcMTO40j+0jmM4K0ZwIUJ9cW4jH5kdnBSLxGwzAhkrBKDoeqdGXBboo9oOuTaSnNCgdsZFIImGWiPgIxAdjEt1aY2eshXhjbdQ13OkhccSN/9s04qi60kMAFDOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1c817a-7357-419a-731a-08def6ba3c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 08:34:47.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVWV4syIf2RXgh3blNMaH+V/urgwLOP4B9hF+HZ9A81/JE01dxl2q2RNYwPssCJlC+kro/MWgYEiTxj6egf4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA4LTEwIGF0IDE0OjE3ICswODAwLCBIYW8gWmhhbmcgd3JvdGU6DQo+IEZy
b206IEhhbyBaaGFuZyA8emhhbmdoYW8xQGt5bGlub3MuY24+DQo+IA0KPiBUaGUgSS9PIEFQSUMg
dHJhY2tzIGRlbGl2ZXJlZCBpbnRlcnJ1cHRzIGluIHN0YXRlIHRoYXQgaXMgbGF0ZXIgdXNlZCB0
bw0KPiBkZWNpZGUgd2hldGhlciBhbiBpbnRlcnJ1cHQgaXMgc3RpbGwgcGVuZGluZyBvciBibG9j
a2VkIHdhaXRpbmcgZm9yIGFuDQo+IEVPSS4NCj4gDQo+IEZvciBsZXZlbC10cmlnZ2VyZWQgaW50
ZXJydXB0cywgcmVtb3RlX2lyciBtZWFucyB0aGF0IGEgbG9jYWwgQVBJQw0KPiBhY2NlcHRlZCB0
aGUgaW50ZXJydXB0IGFuZCB0aGF0IHRoZSBJL08gQVBJQyBtdXN0IHdhaXQgZm9yIHRoZQ0KPiBj
b3JyZXNwb25kaW5nIEVPSSBiZWZvcmUgZGVsaXZlcmluZyB0aGUgaW50ZXJydXB0IGFnYWluLiAg
Rm9yDQo+IGVkZ2UtdHJpZ2dlcmVkIGludGVycnVwdHMsIGlycl9kZWxpdmVyZWQgaXMgdXNlZCB0
byBoaWRlIGRlbGl2ZXJlZA0KPiBpbnRlcnJ1cHRzIGZyb20gS1ZNX0dFVF9JUlFDSElQIHNvIHRo
YXQgdXNlcnNwYWNlIGRvZXMgbm90IHJlaW5qZWN0IGFuDQo+IGludGVycnVwdCB0aGF0IGhhcyBh
bHJlYWR5IGxlZnQgdGhlIEkvTyBBUElDLg0KPiANCj4gQnV0IGlvYXBpY19zZXJ2aWNlKCkgY3Vy
cmVudGx5IHVwZGF0ZXMgdGhhdCBzdGF0ZSBiZWZvcmUgb3Igd2l0aG91dA0KPiBjaGVja2luZyB0
aGF0IGludGVycnVwdCBkZWxpdmVyeSBhY3R1YWxseSBzdWNjZWVkZWQuDQo+IGt2bV9pcnFfZGVs
aXZlcnlfdG9fYXBpYygpIGNhbiByZXR1cm4gLTEgd2hlbiBubyBkZXN0aW5hdGlvbiBpcyBmb3Vu
ZC4NCj4gVHJlYXRpbmcgZmFpbGVkIGRlbGl2ZXJ5IGFzIHN1Y2Nlc3MgY2FuIGVpdGhlciBsZWF2
ZSBhIGxldmVsLXRyaWdnZXJlZA0KPiBwaW4gYmxvY2tlZCBmb3JldmVyIHdhaXRpbmcgZm9yIGFu
IEVPSSB0aGF0IHdpbGwgbmV2ZXIgYmUgZ2VuZXJhdGVkLCBvcg0KPiBjYXVzZSBLVk1fR0VUX0lS
UUNISVAgdG8gZHJvcCBhbiB1bmRlbGl2ZXJlZCBlZGdlLXRyaWdnZXJlZCBpbnRlcnJ1cHQNCj4g
ZnJvbSB0aGUgc2F2ZWQgSVJSIHN0YXRlLg0KPiANCj4gVXBkYXRlIEkvTyBBUElDIGRlbGl2ZXJ5
IHN0YXRlIG9ubHkgd2hlbiB0aGUgZGVsaXZlcnkgcmVzdWx0IGlzIHBvc2l0aXZlLA0KPiBpLmUu
IHdoZW4gYXQgbGVhc3Qgb25lIGxvY2FsIEFQSUMgYWNjZXB0ZWQgdGhlIGludGVycnVwdC4NCj4g
DQo+IEZpeGVzOiA0OTI1NjYzYTA3OWMgKCJLVk06IFJlcG9ydCBJUlEgaW5qZWN0aW9uIHN0YXR1
cyB0byB1c2Vyc3BhY2UuIikNCj4gRml4ZXM6IDViZGE2ZWVkMmUzNiAoIktWTTogaW9hcGljOiBS
ZWNvcmQgZWRnZS10cmlnZ2VyZWQgaW50ZXJydXB0cyBkZWxpdmVyeSBzdGF0dXMiKQ0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIYW8gWmhhbmcgPHpoYW5naGFvMUBreWxpbm9zLmNuPg0KPiAtLS0NCj4gQ2hh
bmdlcyBpbiB2MjoNCj4gIC0gQWRkcmVzcyBLYWkgSHVhbmcncyByZXZpZXcgYnkgZGVmZXJyaW5n
IGJvdGggcmVtb3RlX2lyciBhbmQNCj4gICAgaXJyX2RlbGl2ZXJlZCB1cGRhdGVzIHVudGlsIGlu
dGVycnVwdCBkZWxpdmVyeSBzdWNjZWVkcy4NCj4gIC0gRXh0ZW5kIHRoZSBzZWxmdGVzdCB0byBj
b3ZlciBmYWlsZWQgZWRnZS10cmlnZ2VyZWQgZGVsaXZlcnkgYW5kIHZlcmlmeQ0KPiAgICB0aGF0
IHRoZSBpbnRlcnJ1cHQgcmVtYWlucyBwZW5kaW5nIGluIElSUi4NCj4gDQo+IExpbmsgdG8gdjE6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9hblNPZGlqd1M2TEJiZllKQDE5Mi4xNjguMS4y
MTUvDQo+IA0KPiAgYXJjaC94ODYva3ZtL2lvYXBpYy5jIHwgMTEgKysrKysrLS0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva3ZtL2lvYXBpYy5jIGIvYXJjaC94ODYva3ZtL2lvYXBpYy5jDQo+
IGluZGV4IDc1NzY2N2ZiMmJmYS4uNTQwZTU2NjVmYmU0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vaW9hcGljLmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL2lvYXBpYy5jDQo+IEBAIC00NzQs
OSArNDc0LDYgQEAgc3RhdGljIGludCBpb2FwaWNfc2VydmljZShzdHJ1Y3Qga3ZtX2lvYXBpYyAq
aW9hcGljLCBpbnQgaXJxLCBib29sIGxpbmVfc3RhdHVzKQ0KPiAgCWlycWUuc2hvcnRoYW5kID0g
QVBJQ19ERVNUX05PU0hPUlQ7DQo+ICAJaXJxZS5tc2lfcmVkaXJfaGludCA9IGZhbHNlOw0KPiAg
DQo+IC0JaWYgKGlycWUudHJpZ19tb2RlID09IElPQVBJQ19FREdFX1RSSUcpDQo+IC0JCWlvYXBp
Yy0+aXJyX2RlbGl2ZXJlZCB8PSAxIDw8IGlycTsNCj4gLQ0KPiAgCWlmIChpcnEgPT0gUlRDX0dT
SSAmJiBsaW5lX3N0YXR1cykgew0KPiAgCQkvKg0KPiAgCQkgKiBwZW5kaW5nX2VvaSBjYW5ub3Qg
ZXZlciBiZWNvbWUgbmVnYXRpdmUgKHNlZQ0KPiBAQCAtNDkxLDggKzQ4OCwxMiBAQCBzdGF0aWMg
aW50IGlvYXBpY19zZXJ2aWNlKHN0cnVjdCBrdm1faW9hcGljICppb2FwaWMsIGludCBpcnEsIGJv
b2wgbGluZV9zdGF0dXMpDQo+ICAJfSBlbHNlDQo+ICAJCXJldCA9IGt2bV9pcnFfZGVsaXZlcnlf
dG9fYXBpYyhpb2FwaWMtPmt2bSwgTlVMTCwgJmlycWUpOw0KPiAgDQo+IC0JaWYgKHJldCAmJiBp
cnFlLnRyaWdfbW9kZSA9PSBJT0FQSUNfTEVWRUxfVFJJRykNCj4gLQkJZW50cnktPmZpZWxkcy5y
ZW1vdGVfaXJyID0gMTsNCj4gKwlpZiAocmV0ID4gMCkgew0KPiArCQlpZiAoaXJxZS50cmlnX21v
ZGUgPT0gSU9BUElDX0VER0VfVFJJRykNCj4gKwkJCWlvYXBpYy0+aXJyX2RlbGl2ZXJlZCB8PSAx
IDw8IGlycTsNCj4gKwkJZWxzZSBpZiAoaXJxZS50cmlnX21vZGUgPT0gSU9BUElDX0xFVkVMX1RS
SUcpDQo+ICsJCQllbnRyeS0+ZmllbGRzLnJlbW90ZV9pcnIgPSAxOw0KPiArCX0NCj4gDQoNCkFo
IGxvb2tpbmcgYXQgdGhpcyBJIGltbWVkaWF0ZWx5IHJlYWxpemVkIEkgbWlzcmVhZCB0aGUgY29k
ZSwgdGhhdCBJIHRob3VnaHQgdGhlDQppcnJfZGVsaXZlcmVkIHdhcyBmb3IgbGV2ZWwgdHJpZ2dl
cmVkIGFzIHdlbGwsIGJ1dCBhY3R1YWxseSBpdCBpcyBmb3IgZWRnZQ0KdHJpZ2dlcmVkLiAgSSBn
dWVzcyB3ZSBib3RoIGdvdCBpdCB3cm9uZyA6LSkNCg0KRm9yIGVkZ2UgdHJpZ2dlcmVkIElSUSB0
aGUgZXhpc3RpbmcgY29kZSBpcyBjb3JyZWN0IEkgYmVsaWV2ZSwgc2luY2Ugb25jZSB0aGUNCmZ1
bmN0aW9uIGlzIGNhbGxlZCB0aGUgSVJRIGlzIGNvbnNpZGVyZWQgZGVsaXZlcmVkIG5vIG1hdHRl
ciB3aGV0aGVyIGl0IGlzDQphY3R1YWxseSBhY2NlcHRlZCBieSBMQVBJQy4gIEkgdGhpbmsgdGhp
cyBleGFjdGx5IHJlZmxlY3RzIHRoZSBoYXJkd2FyZQ0KYmVoYXZpb3VyLiAgKEluIGZhY3QsIGlu
IGlvYXBpY19zZXRfaXJxKCkgeW91IGNhbiBzZWUgdGhlIElSUSBpcyByZW1vdmVkIGZyb20NCmly
cl9kZWxpdmVyZWQgZm9yIGVkZ2UgdHJpZ2dlcmVkIHJpZ2h0IGJlZm9yZSBpb2FwaWNfc2Vydmlj
ZSgpIGlzIGNhbGxlZC4pDQoNCkZvciBsZXZlbCB0cmlnZ2VyZWQsIEkgZG9uJ3Qgc2VlIGlvYXBp
Yy0+aXJyIGlzIGNsZWFyZWQgYnkgS1ZNLCBidXQgb25seSBjbGVhcmVkDQp3aGVuIGlvYXBpY19z
ZXRfaXJxKCkgaXMgY2FsbGVkIHdpdGggaXJxX2xldmVsID09IDAuICBJIG5vdyAoQUZBSUNUKSBy
ZWFsaXplIGl0DQppcyB0aGUgcmlnaHQgYmVoYXZpb3VyIHNpbmNlIGl0IHNob3VsZCBiZSB0aGUg
ZHJpdmVyIHdoaWNoIGRlc3NlcnQgdGhlIGxldmVsIHRvDQpzdG9wIHRoZSBsZXZlbC10cmlnZ2Vy
ZWQgSVJRLg0KDQpTbyBpbiBzaG9ydCwgSSB0aGluayB5b3VyIHYxIGlzIGNvcnJlY3QsIGFuZCBz
b3JyeSBhYm91dCBteSBub2lzZS4gOi0oDQo=
