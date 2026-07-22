Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577783D3D16;
	Wed, 22 Jul 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749887; cv=fail; b=c7HGMy/MSdpCxf/FuMzNfckHLZ6xtNKQT4kMT22ncVYIqkCgJ81/0KRlTEMzoBeRiwMOxWPkfnCMUlwbR0BN15OsuioeU2wb2ZMCEgMXs4QG5eW+Zjukd08LgRCn2+oFGTKgZIyFOci/v+9N2yXpyWGzI6+Z3t41b4vf8BcUPCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749887; c=relaxed/simple;
	bh=9+RGF72P+FEWgno/MEQZkT8OsFbeVZbzTF12x8gwWqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SVGcyx9K6PJni+lzVG2QdIQFUI1O+HD+M5HgT8ZkX3K6MfE4ZwNRslDOEqqEdagK1MowRQrNYcnCcUiL1ekjjyzLsMu5a96uf6wcOy2LSGGbewDCgdwIUoec09eaTIfz5ETA8a5g2tEpiCe9oQvzoXci0ND2KXff2/n2dVhdoyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7PKfSAF; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7PKfSAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784749885; x=1816285885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9+RGF72P+FEWgno/MEQZkT8OsFbeVZbzTF12x8gwWqU=;
  b=T7PKfSAFuELgcPoWcKpQ2ZJkpgHqUongEpoVYmErbDyuEPMpkT/6Q+BE
   fJbDO/o1JKjSVzS1ckfLcR0cw3bO26LlN59IIao52s0o6f662JQwnVLDg
   ETVLEPPr7C/197yIJuAv9Gp9+O1ZvxUJ0opsd1z96BjGe9YOOERoyc/6r
   prLlfjHTkGD3thPmod4JR/mbPIbuh0Y71ZueWSqq4OJ5Eh+InQfjMFK2R
   rWmDJim0p7cnmnk5bbcWUFQ5BFwWybav9y3iTyEeCPBTCj1O18FLeFXiV
   kgzKz2bycxRj0n3ZX8pC3LqfpoD/tXMwKh1dKsX5hJLeJWxSjXimr1r//
   Q==;
X-CSE-ConnectionGUID: NbMc68+WToudo/VuO6HGxQ==
X-CSE-MsgGUID: Knt8N/1ZSqaTdZLPcVaRhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85443090"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="85443090"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:51:23 -0700
X-CSE-ConnectionGUID: YMFjWtKdQCqHGsaC6ytjXg==
X-CSE-MsgGUID: SAgReu43QCG6PpuRg0bIpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="263137758"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 12:51:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:51:22 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 12:51:22 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 12:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dv3RMoVG5fPERNTCbISOO61iaomb4fk/RtDri9R1EjV8K46DmWoCdxy8o9b9lEi0TcLRfDbwwQu9afHVZX791rNLA7uUbVe2TsKIlaWzJRFLRqB1kRIvlnQgSlGSMP31zRJfy5etKnUWnNLBXJC2pQb104mPv9VY4w2zgbUziF3r7dN4gU6p+OcatmQZ29jrJYkTynaDbkPq3Wcakg7bwDnqN3rmv28zQ14bSfj3BLFbaO3pOKndYinF2mqi98eQlk0snuChvPVIwtGp0alI484s8rRCh5ZeWxsfFuXfmjP9k/dzGaUBspWVTOvVvg3Lfe6kY8pdgsCbZuxnjZCTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+RGF72P+FEWgno/MEQZkT8OsFbeVZbzTF12x8gwWqU=;
 b=HCYjg40wmhT4zsgwBDHxD1Adjl/pcXPZ/IpPQoxGqcuFL048nZ57f6MFbccEda0/+uX8kmlUEtB1pDR+wj51fTBfBYC/7Zz5X254a4PXR6ibkCPMnEQipAFY+ERQaX6sqQ0KyPrbPBtLa8VA9bHFqPjq1xz2OJtQ5/AJEGWUwJX8FWEeLv8Fi9OnosjSLiBFL1CycNOuPcCsg3+bYdzI9v5gm7bLl+ars6aoB8jBRz5GkFH1Z3mhHm0KUQztxDmfYmWTno+Ikrtbt0dxu+jVXfBXWQEhN9ChoTB6rv1YW5Z/f5FHjaPfuqZ9FmKbkXrwJkihEwpYn+PmpKHn+66/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DM3PR11MB8671.namprd11.prod.outlook.com (2603:10b6:0:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 19:51:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 19:51:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Binbin"
	<binbin.wu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Topic: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
Thread-Index: AQHdFlcgM4x/Hv8VdkeOGppLXPcVVLZ5lHIAgABdRACAAAPcgIAABKkA
Date: Wed, 22 Jul 2026 19:51:16 +0000
Message-ID: <bcde69faf53a3cb045f45d38934459326505cc0b.camel@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
	 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
	 <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
	 <4ad035a82ee10dc4645e26a4bd1daf40786a743a.camel@intel.com>
	 <amEbS6WDEyrvW72Q@google.com>
In-Reply-To: <amEbS6WDEyrvW72Q@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DM3PR11MB8671:EE_
x-ms-office365-filtering-correlation-id: 73b737fc-b098-4dd6-da09-08dee82a9808
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: CQEHlFiie1pUenpbW5w1FbiaocYRRX4v3nrW+qmZ3olzucOIjcJNTs+QHdpDt0kzCvnNg7P/AStvC2etQso4jiByESnjARvZsVXbepoX9PYWiNk+n0BPt79C2KGCO1sNSr0O3fOWAjofz/mbtuNu005QMI4h+A8MF2Y/ufWV944oU9TzXlDiDLS1eQs4MYvmR8HXd+l2VxEmnHx9H9LJ/tLCuuzgTacRMMHQuZZfa8hoUiWYvNzAIAv+M0ZjdRDWYjkZk3i19bVdwaO3e2OrrIj+7pE0mDdgDBaoAM8hBdMpXPsGisUVdu/+5d+yaBsmEcbXLCZVElz2zoSzcpfoG0ajefKeGvdIP0THy8NkGlrgW3ZOsSox9Qhqoy+zhD37ICSwlupcKjQZ9RTyOAqlt0DQWMPGJsbt1fDy+r3j4NP2hZwq08tU8MwCg/3+pYEzxDYhLGH0V90zvBPKch1oq1YrDqXDqS2EowEo/aNAwMMp37prXKJa65xJK9cg/6yRtZJOGptq9fYQWHLL4F8L7sFxie1Wyd7aRnPX+WNiV4YKeWSheBO17k/3Vj3C+mDKMYh5UZHuWql6jA7g+JcYc0BW9m+dU7Bgdh3WIyETHhnmpehO0U2IpSInSfZTbyrw5DC4zcA0ZPDoFtt2g37w8ojPgFCTmzphTtpgXnmB0W6DMjB31vKLzkqKZAq0TbNBdmDmNld0RiZ/QgajjGTclSLrwy61uLyQsKEfTchUFnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWhKeTk2bW53MjM3Q1c0TDdVYnlKaU01QzBMTTJ6cTNETUw2T2lCWGY3V0VK?=
 =?utf-8?B?TWFhK200T1d2bDJGQlBVRWhUV3VIeTNsNm9CVnhyZnJhbmFnbnNJY0NKYnJz?=
 =?utf-8?B?Y25VdW9KdkJ5c091WCtJYytlQk9KckNZYTNSdHdiMFhVVVJGOUZJYzMwV0hn?=
 =?utf-8?B?c0YwVDJnVDNBVStZRUN6cDZqeEU0ZjRqVHNEMHNIczNwY2hQZ2IvU0sycERO?=
 =?utf-8?B?em5WYVhLTnF4SGlhajg0V2NhTzRIZ0R5QmJOaHhCS1lCcmMrdDhlejFrbGR0?=
 =?utf-8?B?Zm9lTDd6clZ6czh1ZnF4UG9mdTExTVUwQUpHdkpBRmwrMEF4V0ovRHJzaEd6?=
 =?utf-8?B?M3pqRTlwY2pSeGN1dWZuOCtKZ3h1NGNrc3BjTk0zb3AvSy80VGlyVDFmTWVN?=
 =?utf-8?B?SGdlQzhYaWpjZExCTnp6Z3JLVGVYRVZPUFFZZ0lYbHMzMHd1aDJndDVyS1Ji?=
 =?utf-8?B?TWNTMmcrSWtqbFdVL0lzN1EyY1ZkZDUyT2pSNkljZS91R3NraWxaU3RKRTRG?=
 =?utf-8?B?MEY1TjdzNWx3M2oyVmdzemloOTRaVlgxYVZJZWR6c09zNGJMVXpzSVcvWWxy?=
 =?utf-8?B?eVJXVE5BWWh3aHdkcFhEMm1oTncyQVV6VGZlck1udnNlSXorYlJ1Nzd5VTBX?=
 =?utf-8?B?ZjdDQzRZdFU4TWgzNXJWdUp6TW8wL1ZkcThXdG1tamFXOXNTM2V5TjlnaGlj?=
 =?utf-8?B?ejlsZ3FFb0xHYXFlNWhic3ZvcmpBNW5QbG1HVWFITVV3WkFZeEY2YnVBaEZz?=
 =?utf-8?B?Y0VnZEVtdTJjWllMMnBCcWR3TXRLai9HMVc2Tmk5NGFjWWNnZk9GaWZ4cFBq?=
 =?utf-8?B?UGw2Z3hJbzVpM09jYmV2UEMzeEdiRzZhNERPRzFhSnpiVEFWYTF6VW9DeEpD?=
 =?utf-8?B?dlJTVzhEVzJpRkdtOUc5ZzBoWVFtdFBZYnl1bU9UTWFkYUtIUk12RjZWck5h?=
 =?utf-8?B?dXowSHFGQ252VmNQQ3ljSHowK2E5eGJMSTF6bFpKakdUV1dRencxdTVzWkZB?=
 =?utf-8?B?REZuQ2pOTVZHaXZVZnRESEgwMTBKdHdRYzVrRnorQ09kMnRSek5jTjMzSjJK?=
 =?utf-8?B?TnFlTlRuSzlCWUQ4bG50OWVyRHcwUnNqRXpMenp2SUNSbTRneUZwOGc1WDdP?=
 =?utf-8?B?Q3VGWXpMYXJUWDdZcDZLNkU2OFlaT0FQY29UcDRTQ0pUZEdoTkVvMzc2eUMx?=
 =?utf-8?B?dURGeUJwSEJ5Z0E1U09BRkZxUXdEU2FEVFhySFJTNjg4WmV6U3g5L0pUcG5t?=
 =?utf-8?B?WUhLd3UzZ1VtUUJaUHI0NjFhenFLYkI1NkVSK2MxZDJSTlVwRzF1dVAvMFdm?=
 =?utf-8?B?VElnTW5PNTNjdGxjZ2xBWmRwNGl6QUl4bFVtVEdleC83SGxmNkpueUxsY2ZQ?=
 =?utf-8?B?N0htWlc5TTJQdy9XN1J3VG11bGJSd0g0cGoySkhpNWNqU3Q0ZWY0YUZtZ1M1?=
 =?utf-8?B?VkVRcmh5T3hldVdUS3FHZEExWHVzcEF3cVZGa2pxWGpmYlRBdVlHQ0ZVS0Jn?=
 =?utf-8?B?UTFDYmJBd2xjbHBRVGFtS09TZitWaU5LWEEwYy8wVEo3QmRGc1dSNXhEQUI3?=
 =?utf-8?B?RXB3ZnJOOVg4M3pZTHFkYlhYMTdnd1dNaW92SFcwa2ovRmFMWXZpL1hKemx2?=
 =?utf-8?B?cDRta2d1ZGhVa21NK0JJM2N6UldXdThyZkIwRlJpMTZOODBHcVlDMDhSQlk0?=
 =?utf-8?B?QWpRQU1FaDROT0RNclNnWjBsbkNYMmUzR25JWDFKKzVFNmcxSDRxb2JxTkNE?=
 =?utf-8?B?OUlnaWMrcHVPNTlYaXZ1S090Zm41d3RjUFl1VFFIalFUWm9hMndZK09aNmhX?=
 =?utf-8?B?L1E2MWV3NFpCVFNncTNOTEltY1hKZTkrNDR0RDlIcUJIdHlnT20rTjFwOG9w?=
 =?utf-8?B?WW9vMlUxMVVFZFhxOG5GOTBEbkZtMXdkRFArbm5OM2h3cVNGQnBDcHFDaDRn?=
 =?utf-8?B?S2dpc1IxZE1WaDV4MmIvSVQzRXJINFJvVUthUm9oVXYzdVJWeDFZS3dTdXZB?=
 =?utf-8?B?TXgxMHRUaUptTnk4Q0NPUWo4ZDY3UldRREcwZUk5K1QxeFBYV0xOSHhnTExi?=
 =?utf-8?B?My9CdnNYelgyYzhnYjlNNlpXajBick1XMUFlVXVlTy9DcW4rQmpvKzN5RzNI?=
 =?utf-8?B?MUQ0Y1lsSFFVVGd5d1VZbVY3VkNBaUNSWndxbWN0YmlCSmc4RHFsQW5yQ0gr?=
 =?utf-8?B?N0FCc2UxaE9yd0hSclVldVZ2ZENaSWVpZ090YkZZWkU1ek5FTHd4cVIxNElx?=
 =?utf-8?B?d3hhZU9WeWI0NFVVZnByMDhuTmJWbzVudHB0MlZ6bXMyRXAwMGNxaHpSM05q?=
 =?utf-8?B?K0ZaeU5VSm81WnF3Q2w3ZEI2bFdHNWxkTVIzWlV2Snd1U0l5QzBiMVZhWWJB?=
 =?utf-8?Q?8CVdODWE629q/ofA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD96A6FCF6F0F45819312A96B391E71@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tAtuQpxnk9z6vtHTqm7MOPJiZsXo6g5idUIeJPE/fz6u+7VAoCS9ENi98113ZcPJdEiQ1XT0kif+sHehzJfna1rGsFsHEbeVwVTZZ1YeZU7O1gINUCpW2RjY4MUDt4AeAyaShOlmx6+NbuD6t/j2oRE+VBo6HXC1EtuaCjDwqwDkqWQnKhJTaxU3AM3RyKvVQl9xKZPHtBPwhW/8ykANO35a2nbajHa5VnlujO1z9rRggv9MOFpxlYLA0HY1wz3hLVHqUZKEtK+bztA9bE4jF4kYFun9mM0T9oNR82drby8LwJLMwyX1FEMYeKMtovK1Mv+Tu8C04qKjmyp5ukbK2g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b737fc-b098-4dd6-da09-08dee82a9808
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 19:51:16.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6au1YefMr3R0tUsIZ5rslkYipaRLc+FnBSP04GClOeBDKAlj1zD3VggyV2UbFTCZ/zeILJH+vBIF328fuKY13EZfHzsXTtVo3++fIf8kaNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8671
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDEyOjM0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNYXliZSBwdXQgaXQgaW4gY29kZT/CoCBFLmcuDQo+IA0KPiAJLyoNCj4gCSAqIE1p
bnVzIG9uZSBwYWdlIHRvIGV4Y2x1ZGUgdGhlIHJvb3QgU1BULCBidXQgcGx1cyBvbmUgcGFnZSBm
b3IgYQ0KPiAJICogcG9zc2libGUgNEtpQiBwcml2YXRlIG1hcHBpbmcuDQo+IAkgKi8NCj4gCW1p
bl9ucl9zcHRzICs9IC0xICsgMTsNCj4gDQo+IAlyZXR1cm4gdGR4X3RvcHVwX3BhbXRfY2FjaGUo
JnRvX3RkeCh2Y3B1KS0+cGFtdF9jYWNoZSwgbWluX25yX3NwdHMpOw0KDQpIYWhhLCB5ZWEuIEkg
ZmVsdCB0b28gc2lsbHkgd3JpdGluZyB0aGF0IGNvZGUuIEJ1dCBJJ20gb2suIFRoaXMgaGFzIGRl
ZmluaXRlbHkNCmhhZCBlbm91Z2ggY29uZnVzaW9uIG92ZXIgdGhlIHZlcnNpb25zIHRvIHdhcnJh
bnQgc29tZXRoaW5nLg0K
