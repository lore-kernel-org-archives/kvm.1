Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC67199D8;
	Tue, 31 Mar 2026 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999796; cv=fail; b=FvSSBf1VCC/idsML4hxSDwgHiSmTo7Jh6x3VWM7ROz8leAEYAxnlXmHx/LGZkdcRrJgu87eddLNsUJ+O/BBr2vZtJbLcSqXtgEa9QFkXB3PlN+HtpwofN1nIfoVMf+yNFs8++iysEMkHGOj04qVPKsE25JeNVal1yKVGE6h1amo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999796; c=relaxed/simple;
	bh=Gh6ldd0/NT8QcjFkWV+6W3FNw9Vh1BiMcIn9jr41WgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mb2d4lai5qlyAa967g10YuMVZ5+YpfRFa1F81i+BJWV7CH45/SnBjPhsIPo7Rnsa78veWxOEYSWqdmuS59ynU+1TJoRp47DfFag0sIbafY0p9+t2tCCDwBZWb04E8JVkqPZkVC1ZhZloGa033y2oDnHv7WhewlVt4Q7xJXVcEpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0WNynCf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0WNynCf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774999795; x=1806535795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Gh6ldd0/NT8QcjFkWV+6W3FNw9Vh1BiMcIn9jr41WgE=;
  b=S0WNynCfzcAJiSAnqBFM7yhDpY1WTViUtF512lrv/rLUwkgI/RkgGiQH
   ZyG5e5HISrkfuoozyVU+NkhCqEkpjYex57hZMPXyJ4x7ss2+wTB4DUbUA
   nAugS5J8S/F1ccuH2vikXkem37AI6D6f2XBu4W4jYAxbEPJHjCagDO3Fs
   oUJiFo32Ex6zEoF8zVAm6/E/6r/3nD+BiZhmaYWmJ33ibaKOD7XH0JhDk
   0k5kOAet376RuL9rz1T6ODF1vlfPNSDmtuKOgoM2rXPj4EIO9SA3CNy2K
   eFrAgPWRAszAYiP9xAyAYb6yKfjbpzwulw1tSdm0nvFpbQm3wXDBqZU7P
   Q==;
X-CSE-ConnectionGUID: 4lDDU2uuRrSwda/yNoA1AA==
X-CSE-MsgGUID: bhc78FMlTHyLKxfDe0HhPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75065926"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75065926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:29:54 -0700
X-CSE-ConnectionGUID: C24ZEvqZRnCaAIq7IK2gbg==
X-CSE-MsgGUID: beaYM5jpSbynb5qxcFy2iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="231441255"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 16:29:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:29:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 16:29:54 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 16:29:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7LmnHave6UnMr6A9Sqcg6KrIddRUWG7NVTDHlaIjFaPS7dREeKcoFIPQ26O7wPXzy5k74rqEz1l0Mj8sWYnfwBjjNkABIjUlGLYowFuUW2EEHOcUeqUsWorA1pAw4A4vk6+y4szUfZVOgqSWB/7kdZle0iUxVChBs3ydZNiHk1/hb6VqYQYIowGmEjNGt7aQOt50h4Nmf+eS45gLJbtp6MgTpwsI5nn3RxIV8IhSSaM2YUEY/vdmZ9c8yev+EA45i60dj2XKYXpdJs8GDItlOEbIO/xYq4SS87q+1Dwc1CQY8m6cfgH+gBxQhDTab8DkdxgsOhkiivlpdKsbqfRTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh6ldd0/NT8QcjFkWV+6W3FNw9Vh1BiMcIn9jr41WgE=;
 b=hPYv7Gdk1QZpyylY5KBEkeoaGBoZx+tsf9KPGRVfK/Py2mlkscFsc7ywQzIo3dSXn3/RU+V//UQeUOBrdJQdaSGUlP7Bl/W1bm8l7OQ67MkPb8AbsapNET2c/3eIGYLmuwBsWH3tA4kCCzgqPtsNmkuZswu8qZm4r09lmBxK3pll+YtpFMvmuhe0C72K81qqI7sA3m2B7+Gh/Qv8L5WNOrwuYP/kw76sKKZ+lqigpumCOTqAMKW8phPLidc2aGtSwRokmQb27CklIEe5YFYgnqQWCfeVWMTUyV0QRtWn2eJ5QjagLQjoXEemkrLGffMiZh4/XsiDpHP18N+HpOZ8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 23:29:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 23:29:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "kas@kernel.org"
	<kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Verma, Vishal
 L" <vishal.l.verma@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Thread-Topic: [PATCH v2 2/5] x86/virt/tdx: Pull kexec cache flush logic into
 arch/x86
Thread-Index: AQHcuwfzpAtra6mY6Ueuk8SDGwySQLXJEVUAgAAyE4CAAAwIgIAABwaA
Date: Tue, 31 Mar 2026 23:29:50 +0000
Message-ID: <5309be7b32d558af01dab46d911e26ec2330e5f2.camel@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
	 <20260323-fuller_tdx_kexec_support-v2-2-87a36409e051@intel.com>
	 <acwe7kKyjfEQ0sIf@google.com>
	 <6ad3ff51bbab85147b716de0b1f4e8b994b1998b.camel@intel.com>
	 <acxTBwaw6_xYSShf@google.com>
In-Reply-To: <acxTBwaw6_xYSShf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH0PR11MB5045:EE_
x-ms-office365-filtering-correlation-id: 9f3ddd59-3195-4ee2-1265-08de8f7d67b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: E4ExUR7Wd7mS8xadRfcePgH0qYfFL9ptaKqDL7qtv9N3Q44pO28Myux0euxgeqQFwuwCAgq5YKO59+crfynoxXOmvH3nIS4i3jCf3WBX9AlZqOmJZDrAES7leGMYzLwiNtGEmMe8e0SgMgWmmLD1Dxrt11RESchtzIkkO1J1z7kDczdFcmCb0+CVTaZFU4B+vEMjaphraFSXEav5tX7ug8lH1F4pCp6OpKhTDpj6dj5FO4A1mH1YulP97oximBAkN95u+/N6l1bg6McV7l47fBfd7ZBGfdgkt+b6ng4U23bNmeYNo1TW1GByo/hIWUWAtSF2oUPcidD5bXHlsLpqJsB98zluVqzxKBp+d/PKbkDtDhS8ERZH+F4ZUhulYtwDkwa2/LGJzJFpJ8yOsJIBW/rRDh7YEdyINoEFg0JwWPHVJNBw52Ira43Mk/sHnhEWQUngQmM6sO2WnB9zugU8fjKLFNqezRwd+sZUqKF3aHxbwxUG5gKC6YAbIQCOYKde9quALdS230ZNF+0NnZFYNfK55VfDKYlV/97Xbffm+gy5DB2Le7oJNf+u/DkWXNCyhRAgB4UM3UzLyF0MD8xI19UkWkqDgqPcAEdKS+0ZoPWIHqVbQXM5Ctey+HbOvEed+0QqoTVOIgyFCMCTnYlXAvLpJFdPeRPdxQzIxKOizMh+OvwIta1pnQfSiqRAYUPEr+HdEa6zKuj6Dd2kw7TfAlDKukapsY/+SLTbuJwxmuwK/kMGbVqPkI+mfws991GQ+2arazkQ8ILEA7fJoe/rdKBExafm4odwa4tR7lX/3+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWhjMzlKb240TXdXd1IyTjk1eHVDODFDb3RweS95NFEwUnEwaVhuWHNBTVdQ?=
 =?utf-8?B?NlpNR2laRFB5TUNhelBTMTNEanFrcTJzM1F4SGpBaHEzMzhUK09CZmF4YVpC?=
 =?utf-8?B?S3JyblRsMDJhamIyYkxVOGlVSjUvUjNBWTBQNVpkK09iVkh4LzBwRHA2NGw0?=
 =?utf-8?B?VmIvSmpJS1oyTEhQVnREd0trSnNDbWplayt1MC9Uelh4YXZlaW1zdlkySHg2?=
 =?utf-8?B?NVl4ckV2bG9zbVF0MEk2czVyeUgyRnhodyt6ZjB2MFU1WU96aDM0WXRhRk9B?=
 =?utf-8?B?Mk51YkRuNDRwZmxnQXo0SllFZEYwSDlsTTZuSzExNUQySEU5dmJKemNkM0lU?=
 =?utf-8?B?OGY3MWR3Z0RhWE1DdDVtRFRsbHNWcFQxS0hqRUF3OGNZaWRrVHF3SGRCdWM0?=
 =?utf-8?B?TzJwdXRGa0ZFY1JFU3d0TmdSRVd4UG5oZm1tS0h2bTNQQ09FQm9WK3BqbVhZ?=
 =?utf-8?B?RmFDQlhWeFA2RjhtZ2ZLZEhiaVJZYm0vYUZRc0tLYnNCRlM5cmdnZDJwQUNi?=
 =?utf-8?B?eXBZcEFuY053b1huTG80eTAwbE1zYjNxYW9NdUlCY2U1NjhkMlhSOXJKcjVE?=
 =?utf-8?B?cVFBQTVBQWE0cElDYnNoc1A3YlBkaVg0M1FmWFBHNEs4WDJIQkY4UmdtTnov?=
 =?utf-8?B?OEhQbVluZzV1bEZ3ZEEvTkp0aDE2c1ZSOUo2bVNMWWJuOWlIeldkcUFYMzZ2?=
 =?utf-8?B?Rmkxc0FoNXFZRFFyYWJ3NnFtRXppQzFrNUxJMHoxWUlWTnRZNjZzZXZJc1c3?=
 =?utf-8?B?Y2k0cGVUMWtuUzhQT1pSc2UxVjVjeVAzd0NNL2VIQ3N6SE9VUWNWOXI3disv?=
 =?utf-8?B?b2xHNzV3RnR4ODRCdTZUR0YrcEphbkkwMWpjNi8xOXZHTHo4TXNFam5Eekta?=
 =?utf-8?B?TEhEZUdQeW14Q3VhdDVwT1JuRXZtYzgwcDRLaS9uSGNwK0E0ZDE5MTBBYUxQ?=
 =?utf-8?B?SUtPdzJsVGtPTTE2WlBQSkVDZExCbWxKQXl5NWpSd2FYa2Njb0hKZkZadndz?=
 =?utf-8?B?VCs4V3hlaHhjYytSOWtOQS9qMzZBNDVDMFF6MHlkM1hKbGFuR21mM1R5eFJ3?=
 =?utf-8?B?MUNiNERTMnZwbUEwaU1mU28zU2NZZ0dPVU5KYUNQa2V2cEVaQ3JGUmVKaC9k?=
 =?utf-8?B?RmRqOEVnT3lhQk5SWUwzM1NWTWlBNm43NGJMZ2RhV1gzclR0UmdjVnFMblhN?=
 =?utf-8?B?Q1hSeE5KcjZ1V21XSmcwL2VrSkRJejVTbXJDMm8yZk1pOGtMaUo0OWlFRTBp?=
 =?utf-8?B?OW55ZzBuemo0MjJWMlIvem42NHh0TXI4bkc1RDI0YmkwRFpoS1c1WmhkZW9W?=
 =?utf-8?B?U1BqYS8rOHpUeFZ0OURyQVZrY21vc0JOc2JnZ1hYL0MxUUU4TUJHNVM4ZlJh?=
 =?utf-8?B?ZFRRVGZCaVc5VUFEREQ4UXVtcDZ1bWEzWkNEc0NDNEFtZlF0NE1ha3hHQzAr?=
 =?utf-8?B?M2g5TlBZUzluT2tkeVlSL2tEM3lhOWpyRW5nVHg2WU0xdy9WVGFUQU1ySXcr?=
 =?utf-8?B?YUlTWEE2cFlQQ1NTaFJ3YlVzbWt5UkdkMksxSU1NS0MwTkN1QzQrczNURElq?=
 =?utf-8?B?cmZFNVM2MG1RUjBTOFBqT0FzRmdUbU1mWm1iWmdRV0xBTC9hZTVLU2xtK0xD?=
 =?utf-8?B?R29RMFNGZFBhQVFmWjB5Vms1Z08wUWNQMWhLTXI5YmNmME12UFYwbXlySENZ?=
 =?utf-8?B?Mld3VzFIZHJkTnVIb05hOERJOTdNSFVwSGhsNFI2OUVSUVBqbEdNRGhmb1VC?=
 =?utf-8?B?VnkzV1JPVk12aGpmRkR1c1Vtbmo2YlZEUlRubzhkS1NSMDlaT21XWGw3NjN1?=
 =?utf-8?B?ZW1INHhEc3BLL3JVZm5JMGwxUjRXSVZzOXJ4Uml5VFdlVDhuSnIrWkJLS0Ja?=
 =?utf-8?B?c0hhZmduY3FVZldDVVI1bGlEVjZuYTB3YUJJM0lVelFWd2hsOTJ3aG9RVVBH?=
 =?utf-8?B?eVpMT216cS92RlhnV0NmcVFsL2EydHRuNE5zeklkR0RVSDc1RWM0Z0RraVB2?=
 =?utf-8?B?L2pVK2MwZmVVQWpSOThRd0RYbGtVTHhxWkpQTE40VGdoZmk4bVBWZ0RrMGhY?=
 =?utf-8?B?VzVCSkU1OGRHamhQNlhJZDQ1QnZ4Q3NUZENhV2FpQ0FyWjlpazBvaE9wVjRt?=
 =?utf-8?B?Tmk0a0oyV2pRNWI0eW1Kc05DRFJRMUtlb2VQT1c3U1NCSTNkM1NVTHdKMkI0?=
 =?utf-8?B?R01IbVZxek1QeXU2VmkvM3JaRkRvUkF3U052eUhIaWI3cy9MWTR2NktwQU82?=
 =?utf-8?B?ZUcrSE1lbnNCVUF1MU51V0RwOWRjQkdscTRuS0tDenlaUTc5Y0NjNExzT2JM?=
 =?utf-8?B?YzB3SXo2NXhkR3M3NVc3RnVuTXU4UXRBbnBOcHNGT3pwN3pYc3JQdVFYRnVp?=
 =?utf-8?Q?pWJZUHOtWug4BuCY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9F8F1C869298B4D96C5449A87AFB17F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JV7CryxeFLAXymV8pYwecguTG6rE2K76iQuViBfPSTknDMhIcK00QuPIC3KGTBOxMe+G/OrnbeoLo62SnFeJsBB4P3xuHXJ63Gow1UYbTcds/o1HAa/yHsplQtVYPWMa2cnsv/io6b4RlFpwzK7JWDWFT6rGGYjRxSZ6MvGa8ZGF8sv36mXBZPOsPGuI66eNwMXzzMlbbkQHUWL14BFO0uq1tIEPqvK+6K0YfnhQpHOf/7UKxVqt+ND+z1nAgKshQDauRAhmzDAHQrw2Jzz90mG9XTLIIiDhCTTSsS+Ew3hKVBqKFVhe3ZzPM72E37r1sYYdS9ubb5rk39l9zUHehw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3ddd59-3195-4ee2-1265-08de8f7d67b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 23:29:50.6528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2O/efUSD/0BK4P+9AVnjvKut7YfbkYJKf9nRAgv4ebGTGiVhe7WIbX2zVfD4BSba5ruJt1yGvDQJepxdrIvGBZ32UexQOWG1+TDqKAfmoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTAzLTMxIGF0IDE2OjA0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IE9oLCB5b3UgYWNrZWQgaXQgYWN0dWFsbHkuIEJ1dCBJIHdhcyB1bmRlciB0aGUg
aW1wcmVzc2lvbiB0aGF0IGFmdGVyIHRoaXMNCj4gPiBwYXRjaCBoZXJlLCB0aGUgc3BsYXQgd291
bGRuJ3QgYmUgdHJpZ2dlcmVkLiBTbyBpdCBpbmFkdmVydGVudGx5IGZpeGVzIGl0Lg0KPiANCj4g
QWgsIHRoYXQncyB3aHkgSSB3YXMgYSBiaXQgY29uZnVzZWQuwqAgSSB3YXMgYXNzdW1pbmcgdGR4
X3NodXRkb3duX2NwdSgpIHdhcyBhDQo+IGNwdWhwIGNhbGxiYWNrLCBidXQgaXQncyBhY3R1YWxs
eSBhbiBJUEkgY2FsbGJhY2suDQo+IA0KPiBIbW0sIGlzbid0IHRoaXMgcGF0Y2ggd3JvbmcgdGhl
bj/CoCBBaCwgbm8sIHRoZSBjaGFuZ2Vsb2cgc2F5czoNCj4gDQo+IMKgIEhvd2V2ZXIsIFdCSU5W
RCBpcyBhbHJlYWR5IGdlbmVyYWxseSBkb25lIGF0IENQVSBvZmZsaW5lIGFzIG1hdHRlciBvZiAN
Cj4gY291cnNlLiBTbyBkb24ndCBib3RoZXIgYWRkaW5nIFREWCBzcGVjaWZpYyBsb2dpYyBmb3Ig
dGhpcywgYW5kIHJlbHkgb24gdGhlDQo+IG5vcm1hbCBXQklOVkQgdG8gaGFuZGxlIGl0Lg0KPiAN
Cj4gV2hhdCdzIHRoZSAibm9ybWFsIiBXQklOVkQ/wqAgQXQgdGhlIHZlcnkgbGVhc3QsIHRkeF9v
ZmZsaW5lX2NwdSgpIHNob3VsZCBoYXZlDQo+IGEgY29tbWVudCB0aGF0IGV4cGxpY2l0bHkgY2Fs
bHMgb3V0IHdoZXJlIHRoYXQgV0JWSU5EIGlzLg0KDQpJIGd1ZXNzIHdlIGNvdWxkIGFkZCBvbmUg
aW4gdGR4X29mZmxpbmVfY3B1KCkuIFNlZW1zIHJlYXNvbmFibGUuDQoNCj4gwqAgSSBhc3N1bWUg
eW91J3JlDQo+IHJlZmVycmluZyB0byB0aGUgd2JpbnZkKCkgY2FsbHMgaW4gdGhpbmdzIGxpa2Ug
aGx0X3BsYXlfZGVhZCgpPw0KDQpZZWEuDQoNCj4gDQo+IEJ1dCB1bmxlc3MgdGhlIFdCSU5WRCBp
cyBhY3R1YWxseSBjb3N0bHksIHdoeSBib3RoZXIgZ2V0dGluZyBmYW5jeT8NCg0KV2hhdCBpcyB0
aGUgc3VnZ2VzdGlvbiB0byBtYWtlIGl0IGxlc3MgZmFuY3k/IEp1c3QgcHV0IHRoZSB3YmludmQg
aW4NCnRkeF9vZmZsaW5lX2NwdSgpPyBZZWEgdGhhdCB3b3JrcyB0b28uIFByb2JhYmx5IHdpbGwg
Z2V0IGEgY29tbWVudCBlaXRoZXIgd2F5Lg0K
