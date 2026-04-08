Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F137996C;
	Wed,  8 Apr 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683768; cv=fail; b=fdzF5Gx3QggQryE7fXBilkKm2zN2n/Z4GlaqNQkuQtqNrCjwD2mROh/UfFXSAJ/2LCS9jQoVV8gjzy29O4n04opT9rXE9wdroX3zviP9pCxjDaCF7nsJ9GDfQvDLLAb7+82D9BWxgtqRmjiQvPODAS6u71xGRRwRifRPvbbbrUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683768; c=relaxed/simple;
	bh=MvJNuKuv33A2yIvp1Oxsq0p/GU2tTF4XDbM05w7Yt7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pH+zyV34bsJy3aOFlj7v+HHk/dwHTBj7xcCQMSDrCkg/9Y8fQnOq1jotTCynVLx9LjP52MkwKCrkNzpJmPy9vGj6fz6aS/OkXRC2AOYrKPgvVsJRzEhSw1tjWLMAoIjqf6fvbwTI6S4nV8/nFYoRv1zlxEQ49i7xK4zUCxcjo2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFd/srTM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFd/srTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775683767; x=1807219767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MvJNuKuv33A2yIvp1Oxsq0p/GU2tTF4XDbM05w7Yt7Y=;
  b=TFd/srTM0erCqr8o7pIcCNvGQy5WZRbABalvoRGUT8z745FJpVjJApyp
   qC01LPIxCcbc/l8gyG2uF54LnE3uq3OsPGApygg+OmJJOx2yku9UGIRr4
   oi2u5iAL+OZ9ZI906RsfmEWwkbh6zhtQxRLt7QY+NtgmWtSo54WSMjEmz
   tvTGpNE3bddm31rAgyC5TJf00nj5Llm+zSlw7Dza8MFE6RtYIbF8B8v0i
   MiXMH6nljpidG3vJHHMcs0vOSWN6afRB5RVGRTqIkyGQCSR28M0NPV028
   3fmLLeLrCo1ZTKZZS/U50jtFh85nwi4rfgE12U7tWj9cf25oC4cHZTVXS
   w==;
X-CSE-ConnectionGUID: OorBmaW9SGeJBCtX20uM+g==
X-CSE-MsgGUID: r6Nt/wZSQS6E66QXTHnvoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="79271649"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="79271649"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:29:26 -0700
X-CSE-ConnectionGUID: vtAcG8nzS8mXdMrLpbteWg==
X-CSE-MsgGUID: N96K16lESqSjZNznptsxWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="232617867"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 14:29:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:29:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 14:29:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 14:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5DNZbOqe7lyy5Dt+okIBUxjcAv1RPWcl6K7IvTzMQffDhexPdClR0e2mtpjZ1p+kBgOBWU6tVyzSxrHltWi+QXbJktyqEPUwzuy4+szLt5FKtbD1/Ltt+CZMtd6i1jEOrKZ7oSn22rKAof+mPfKwHzVfY2QmWU2LsjvYCh2OFKY9hY8Ni2J3gur7xQKfsqC7Ukw3cnNvZUtT+h8cnzGTwIBHt38hBrUF2fRB38ILFKy4uS+XYXdIQaUrUeqaBDDKuWWT9bDKkCYPJ+b/jexdRlJ55I0Zi6ee9CTjlxxY8gD4oDNfB+U+4CKznXUDr7AfU7GJ35XLEmmouGxa4aJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvJNuKuv33A2yIvp1Oxsq0p/GU2tTF4XDbM05w7Yt7Y=;
 b=mEDxdZxYuPGpwG87F2K6dSi77lJTP2wwDJnWwLBkY7S+6RTPBppiJkNJ3QnROO1wYeP9PksDQ4Rd8u5/D2oyakxxOCzMabVZdELFlQwdekYGZPPs5JFOfR4Wd+KQvahlhUWmUX3VzOnsBGZr+cAe/HokqcOzLDabnPHNF6SW0e1Z25PAsdXOpYIlMLHu3rh0SzZR3IyfSAzOdMQM7xRGEPlAdSvmsq9MSINuSdEwhqi9qiwG0iXWeDQtCXV/5aXwhDZjGbsF8TDSrQQd+Ldkgi/dYsqwqGo3uu2PNHXGq8S6/GCPSlV9xIpjKffb5pvUwcJolF7l+kASpTStO/FHSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ1PR11MB6227.namprd11.prod.outlook.com (2603:10b6:a03:45a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Wed, 8 Apr
 2026 21:29:21 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9769.004; Wed, 8 Apr 2026
 21:29:21 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "nikunj@amd.com" <nikunj@amd.com>,
	"mtosatti@redhat.com" <mtosatti@redhat.com>
Subject: Re: [PATCH 03/27] KVM: x86/mmu: free up bit 10 of PTEs in preparation
 for MBEC
Thread-Topic: [PATCH 03/27] KVM: x86/mmu: free up bit 10 of PTEs in
 preparation for MBEC
Thread-Index: AQHcx25c0F69MbQDIUqQQleRkFbIibXVrqeA
Date: Wed, 8 Apr 2026 21:29:21 +0000
Message-ID: <56a02e81b40343145c312fae64fa07b29c5ec366.camel@intel.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
	 <20260408154217.458420-4-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-4-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ1PR11MB6227:EE_
x-ms-office365-filtering-correlation-id: def14a7f-3fcc-40a1-fb7d-08de95b5e623
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 5bGH+F6LrxteISYICwg9EV5AkTccfW6dy9VEQxhqK4TbAp6HgBrCrXp4UZ+479ofllGzolSkrABNIVOFYg84L76jbFZXpMKaxcYCHliwXx+g2yQncUBk9F9vKtorZWhJCFobDJwcLKuRhG90sJRcVwJVst4Z7WS5w4GT/l/oTBniidLjSf1CaBBYRIpGqJ9MQSyJLrJWk3dNiVTr81G8O9Cruj4CC4/fmp/oXxg6u1OYj3/shdGEi/xAs8DrDPct5tSDOofsxrhQDwQFZwuaBbxYiIdJyzJWJW8vhgWV90hneOOl8unBxMKKlH/DQ8Dj8Il4pf5h5Yu1XfCr2wM+XtzZ1YYWgNDRFm5NK/fdWVQ0gZmfNYBwxbfBuH5JpgAPeyB1KYhUrBt8XBlM7H/Wf82aOyzhGeJluL8IaVirRFG5pT5enh0RcKy0PX9wxf+XI4YPnSGFRfcBNugkm5elwoRGeLWnPMhLvHLax8X2P+Ubaj/D3wQDXjL1sVz/BH7NVFHwK4I0fKGtdmbPS3g3AYg/xzBsdU0sY/a1t9HMK9x5mLNOlRweV8scdUBeotGK8hz04pHFWEOsga3AhCTo8/ejps0darN3FgBNeOmtAJW0YKl5Oi+gMUJLQySQdbJMPeTN5l3i2qgm+a2j6BRreb5Fy7SOjt/fcCF8rz4vS/j1Yho8chl6bj2EoW/5KyPpSTKkXN6mZ/CwPRQL4nNKzRW9BN/VzYpXnJr4NbXjr5QGXTEPmr40PFWZ31CivpofTFl6lfEPmE9ojh812pWlkTa1ZwxKtZ3Jg85GeAMOB0s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW84OUtGNGhBQTU5eVhiT1hRbUJ0M0k5TzZrR3dSQlhqQ2hqR3BoMU15WWZT?=
 =?utf-8?B?RGZPdDZyUXJVc09YbCtzTmVWNHJBRWtDQ2ZIUCt2eGJBRXNiN3AwSG85UlhE?=
 =?utf-8?B?dFZsLy9DRnJQczJBSlBJaTBqSncrL1JLc2VaY1F5S2dhOUxxMU8rRzBJTVli?=
 =?utf-8?B?cGsxaHhpYXE1ZEloNExLOXkzSjZ3WjJpdmoxNmt4TlAza0c4dERDbDZxSUhV?=
 =?utf-8?B?Q2I0d2p5V0RFdDZNdll0K3VqYXJCeE5wT1NZVTFzVmhrdnRSMGhGa2FraUwr?=
 =?utf-8?B?dW9HZTJMTEg4NEprQnhHM1hsV2kyNWZzVk8vM3dkOTBIR00waHg5MnkxZElO?=
 =?utf-8?B?ZGQzd3JRcXhqUDBUSk02T094MFJlZFJ0R2E5eVAzTkV6bWNZRitINVlqZ3Q5?=
 =?utf-8?B?YlhTM25ZK0drb2lWbHRKNXRzNUcrOUJWTkN6N1Ntb05DTHRxVnpab3liTFh5?=
 =?utf-8?B?Rms2Tm5lMExsZmZGc3BMM2hwSklwcnczaVU3UjYxYUJpRGNmMWovaFFBYXQ4?=
 =?utf-8?B?d2x2SU9wQitTM3dyeDl3Q2ZReGR0bGxIS1h4bjVOcmhTOUVQL1VxMk9oTVBw?=
 =?utf-8?B?OUJVdHREOVpjdUZ2TG13aWVFb3BjL0JxV2JIeThvOFAxMVBBalJPSHFpd1Zi?=
 =?utf-8?B?L2I2K1FxalVxWUdnL2N4WE1UZkYzNWZsOE1mT3V0TGhaeFNJWW82VkZ1Nzlm?=
 =?utf-8?B?VmgxMk1mQlI4ZUJzbndJR1QxUXNONW04b2UwM1piQ0YyRFVpYldHSHVqdC8y?=
 =?utf-8?B?MCtDcFdUS0pOcTdkdFkxSFFQMmthaWtoT2hyb01Fa0l3dk1vckk3QnozanVT?=
 =?utf-8?B?WmxYcHZvU3BxMFRzWkJJOUZHWUpReXFXUktZK2RGb1JWUFdZdDRsM0VtYlNO?=
 =?utf-8?B?eUw3ZHNDWGZYZmR5c2RzTDVhQzlEaWM3UGZQUHgzNXNJWmRCYkx3cFl3QVRB?=
 =?utf-8?B?elNNK255a1kybW1VY2taUFYzN05ldGZYUUF2YkhQdFM1dUxsMjZmZEtzNElW?=
 =?utf-8?B?QXk1Y3BGNUVZaW00UzlRc2ZVdjErcnByNUtWYWNaN1RVSWRNV3RJWmt6MWxt?=
 =?utf-8?B?ZVJsbFFTeUhaR3VGVUVXRUJ2MEo0STcyZEZTcDNUZnpSRkxXRy9JUUVzL1VW?=
 =?utf-8?B?UG8ybHZiMDRMc2xBbjlhRFN4VGFrQXdtem5BRnNYbEpycTQ3WVR0LzBHOVlP?=
 =?utf-8?B?N0FKRDB6TVRxNkdBaVFiVWZpVkMvM0pFSjhaMkFaUXFPOFpjZ2lSOTc5MnRY?=
 =?utf-8?B?cHRkTG1XaG1vYlRsQ1VTYUZQQjZDanRMVkI5SXY0bXR1Z3dHQkJJbzl5dVln?=
 =?utf-8?B?ZG8vSDlVV1lhbytnK3NZaVFySThRZWpxTWZ0V2JWYndJNkV4NFM4d3VIeXd4?=
 =?utf-8?B?WXhOdk5tRXBHcDNtV0Z1eFdiVkJFU3I1eG9jKzFjbnVXU3Q4VCthb1N2dzhk?=
 =?utf-8?B?Y044Z3c5UHdkTmkrMUxHZnpqclFONDJ2Q1F0ZzZYMnhheEZvcEtHMEh6RlVj?=
 =?utf-8?B?TzNLTHhiaG5ZbDRPL25ybVF6YzRFMFNtdzUvS3l4dEZ1RnZsVXpxQ3hoc3l0?=
 =?utf-8?B?YVhZQVhUTU1iQXY0aGhLRGFudDc4R2E4bEZGWWp2T3BTdWl2WlNEdWo0Tzhk?=
 =?utf-8?B?a1dVWDhOT05aYXExR1NYZWxSN1Z0VE40MDFUUk1LL0ZSZjIzR0FFUFlVVXJm?=
 =?utf-8?B?N1gzQ21tUkI0dkJJeEs1UTVJcHhCOHIyYy80N2pZZFJPK0dTai8wSndadjcx?=
 =?utf-8?B?cEY1ZnZqdUxZWDROYnJkSmlaQTUrUzh0NWpUbGJjYlNxTDZpc0FoYkd1enJi?=
 =?utf-8?B?RnFiMERLUEhTV2dwaFpsWDhrN1JiWVhZTnhjQ1BaQTZFd3c1aEJPaXltYWNy?=
 =?utf-8?B?ZzBLdStHNUxHWTBHZktZQVhaNVJocmt1VkF0ck9vdlczV1hTbTJiRW5jUmYy?=
 =?utf-8?B?UjZJTUlyQ1ZydTQ5cU5FbThKRWl1NjJUOEEyNXoxS0tlRW5JVm5RR3lIRms0?=
 =?utf-8?B?TXZoRGdtSm5ZdGlQQ01rRkk1NW00eW1XT09mZkRvR1NDeERnSlNIYUFoQ1Nu?=
 =?utf-8?B?Q0FiWHR5SjJreUhwSmNmUlhFcmRScEtFT1IyNHNyNWVjbVFCbk93WnYzV21k?=
 =?utf-8?B?UmhEZkRRcnA3UmhnK0tLUFZvSkxZa1cxcVZKeWQzaWV1cWJlK2x5UGhNcWFQ?=
 =?utf-8?B?VktkTTRHWEwwYlg0ZlNwUHhKNitWK0U0R1RiUTd6c256UUNWbFMxWGtUQkJP?=
 =?utf-8?B?N2syUlBaQ0FTaC94c0xVa0Rocm9DaTgrWVREdExnNW1YN0N1SWt2OExDZTR2?=
 =?utf-8?B?ejJCQnVCbGZIcHZaUFE5czBuSWNIY0h3L0dueVZjN2VaVjVRa1FhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AFB77E1F695AF4E96379209DB1ECA8D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v6TuDKuhZp0gDyKIdnwtzjHk9cjQI2qQGdba7SbLZ2OjkV3HlZnudbPeQtUq69c3BYTjxd1VD3+C7vBCMLnL/7RQ901wTb0w9zYzYBIWOchBXdkdskAMOnZ7bmyu2BaeupW+xHjb3Lw12DW3ihsx5kvXBNSeC9mabu3kA7DXN02XWQiO6qQTi2D5sb4E3NcmKcGQCzPU1zCyKFJWoVTiiG4NDM9UUxBn/ScNA6hudvLgvJiH9u1nTPULYCwAWMtDU5RFXNJ+GDbFOaf0BIHv4MI2/ewPD+VX/mh2/JqjJ7wNkHWjXpznOrtGp8DevKlBVX4+Z1kt2lrN/wY7TEBwjQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def14a7f-3fcc-40a1-fb7d-08de95b5e623
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 21:29:21.5826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MhX1I6MUUG9CRLrXXajSRpFQvewwk7T/SD6Ttas/EYVb8TSD2VrTBh9IYn6ksnv7tOr//yBqdKKuPORB4ySag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6227
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDExOjQxIC0wNDAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+IA0KPiBVcGRhdGUgU1BURV9N
TUlPX0FMTE9XRURfTUFTSyB0byBhbGxvdyBFUFQgdXNlciBleGVjdXRhYmxlIChiaXQgMTApIHRv
DQo+IGJlIHRyZWF0ZWQgbGlrZSBFUFQgUldYIGJpdDI6MCwgYXMgd2hlbiBtb2RlLWJhc2VkIGV4
ZWN1dGUgY29udHJvbCBpcw0KPiBlbmFibGVkLCBiaXQgMTAgY2FuIGFjdCBsaWtlIGEgInByZXNl
bnQiIGJpdC4gIExpa2V3aXNlIGRvIG5vdCBpbmNsdWRlDQo+IGl0IGluIEZST1pFTl9TUFRFLg0K
PiANCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzIGludGVuZGVkLCBvdGhlciB0aGFuIHRoZSByZWR1
Y3Rpb24gb2YgdGhlIG1heGltdW0NCj4gTU1JTyBnZW5lcmF0aW9uIHRoYXQgaXMgc3RvcmVkIGlu
IHBhZ2UgdGFibGVzLg0KPiANCj4gQ2M6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPg0KPiBNZXNzYWdl
LUlEOiA8MjAyNTEyMjMwNTQ4MDYuMTYxMTE2OC00LWpvbkBudXRhbml4LmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3ZteC5oIHwgIDIgKysNCj4gIGFyY2gveDg2L2t2bS9tbXUvc3B0ZS5oICAg
IHwgMjAgKysrKysrKysrKystLS0tLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS92bXguaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZteC5oDQo+IGluZGV4IDdmZGM2
Yjc4N2Q3MC4uNTllM2IwOTVhMzE1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS92bXguaA0KPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92bXguaA0KPiBAQCAtNTQ5LDEw
ICs1NDksMTIgQEAgZW51bSB2bWNzX2ZpZWxkIHsNCj4gICNkZWZpbmUgVk1YX0VQVF9BQ0NFU1Nf
QklUCQkJKDF1bGwgPDwgOCkNCj4gICNkZWZpbmUgVk1YX0VQVF9ESVJUWV9CSVQJCQkoMXVsbCA8
PCA5KQ0KPiAgI2RlZmluZSBWTVhfRVBUX1NVUFBSRVNTX1ZFX0JJVAkJCSgxdWxsIDw8IDYzKQ0K
PiArDQoNCk5pdDogc2VlbXMgdW5pbnRlbnRpb25hbCBjaGFuZ2UgaGVyZS4NCg==
