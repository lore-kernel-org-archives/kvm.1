Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B03A8F7;
	Tue,  5 May 2026 20:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012842; cv=fail; b=Htd41A7JauFaWjTcY3Hj61yx8nTPbzdi5FJkC2Z/TXTN7JSvP0XHWTXbWTQEKDXRwAg/YQ0AGQ0fjsz4+nleLwuXhG+fMj4gab+eQYHBy6ugL8Dyhvlb0xEIGqz8bXAL/0ivOmsC5veuD4bPfBuD7mN54JDKmySptP0XpmE5EkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012842; c=relaxed/simple;
	bh=7Mw0UTGWWuECWI7gW/q0futVk0mSnQpvsZt0nG1qpoE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nAiSXxsUGtOFKcYD+PeBgQNfkdP0AKdIxS7DLLQEiEFmL2lRzYev+SNHpdG9pbK7c09EPTay2wJBMLqHKyzRB0/Yn7pZFZvU5i3xO8MHPqzV18m73559ypMXfRLZZAaD2WjWPWTZdZOyV3EsDEqTXAN33gVDxzXXEwBqakuR3wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=yJbAjvuP; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="yJbAjvuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAOQHX6TE4PzAYdkOUhduBN+ZcGAgTE9d327VkZ2j+jdj6XsJFxMmCS2aSq67Xml2BFN2nBWf1td87k1g7npXh+saeeOR6SLSP5BfQ9ikdxPEMkVPGf8NpfQO+F6iesSwAPDB8CyxZ1wjTOGU3gR3RkwvzGxp3oNyrxA0HEapsoDETHbF0PjzVvu5PqO8VVa2QlRh3tICbQMrQl0z0iTEZG6dU1G7pVTD3yAbYxd1+5w7xZvU2nLbt0sAz8+bln+ycp7NJnIybli8ghsWA73X/6nBe1aIQ8FIkJgOw6RezdWbm/O8GsyBUUPkeRxvjUhQkfd6ZdX3N+Kt6T6P1mnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mw0UTGWWuECWI7gW/q0futVk0mSnQpvsZt0nG1qpoE=;
 b=aYOV5Aqa8LHb8cFdZRS8FEpPtho+/gQrSWeEEYFu93we3zqtIFjpRv+3PoYbfSLFrPU/re7QaazQSlTan1xy78LzXi7Wq/wySBKtHf16w3+0ccuD8YP0EqjYBszJBGTrlGMTzrJSf3kQTVbL0QMRXOOFHrGG4tTGLVbz9tpW1/duu2bXw87Hvlrl7E21NZ/EK6rxyMM+LuT4MuKYkNhpWrQtldJlak9xMKICs/PFsFQDfmVk89rVg8tWnsWRIJ4eKauEPPXkdPnsDkJ0WpFbcnYYh5mz46pzUAOknf1+YWwsyqMGzF5cvDqaVfxU17vDLF+rHBZy6mdHw4Wrm7feAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mw0UTGWWuECWI7gW/q0futVk0mSnQpvsZt0nG1qpoE=;
 b=yJbAjvuPxigUJJ5YF8en+lMBmx34lIL+j8nT6i3CbONpgKsPbZX65TI6dXOSE8FsCjOym9WtYsLreClGdqZfOnx1Hu5H2HGtz//dHc97zBf3YnXI6Pab4X5OohU2tp1hDulrvy/p9+w12iuLSv8PfM1QIPbS2qNjJVvqveFz+BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by CH8PR03MB8322.namprd03.prod.outlook.com (2603:10b6:610:2bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:27:17 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:27:17 +0000
Message-ID: <0cf63e0d-8983-40e8-bf0c-938affb73744@citrix.com>
Date: Tue, 5 May 2026 21:27:12 +0100
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 "Saenz Julienne, Nicolas" <nsaenz@amazon.es>, pbonzini@redhat.com,
 seanjc@google.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, chao.gao@intel.com,
 hch@infradead.org, sohil.mehta@intel.com
Subject: Re: [PATCH v9 00/22] Enable FRED with KVM VMX
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org>
 <DADE0E58-DD8A-4206-BF54-1DA87864117D@zytor.com>
 <afojoHJSlqqm2Ges@wieczorr-mobl1.localdomain>
 <f4cb5f8e-caf5-4513-9538-edaaea20de2d@citrix.com>
 <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <afpPt7gObsyFkPRy@wieczorr-mobl1.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0547.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::16) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|CH8PR03MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: a9017d2a-0702-4d92-6018-08deaae4b38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EphxtRiaK/IpEATfiE6rVE6EHPGoTbk8LrfVHBYGRNFkSiZT+X5twD0lMR85K7FkSU5tHWb6fBCMCkaBIHufN10IcEkF3+XV3oLAfiQ9UqpXCvxeN6FzTZyyR4GLX5QAGOp/uxAl02UPCiXJUD2KYgd8FFK5iFEC5UJIvBtXTnXngFmuf6XOLsU84cffp7g9mZIAPIfXRMrJa78XFvOup141miQ5yIjIYKTnKN2WVt6yFZiq/P/olEP1TL5dvZhxOO1NhGkXTPv7TizBHSS7Yz5pFXSx5gmn6P3iWwSDbBLJt1C/Kkb2s69F/1WFLVGOwbBePI7A3/fEjoaFBT1gUNAw/67TxDM5enUj5nmAwZRhiGjw1i9NzoafbqbFZTtkOvqFVfe0HcZpC/xzgJ7G3JptBPKzpJhGY5ZNpATYdfAlQSKvEujvSCwlR30dYKhhHGQqNafmk5KZSJeTdBEfal5HhE0pchH3u2myO7kEalVBW0+Or+IneXFWWDkXt4+CqiGgbULnnuhg/CLEcdhfXSsMwp3TxJhZEescv2eNvmvGHwuVbRdjqfGvhaXrcxggvPkbb2Z1WSWFgpW7SDvn2W50ELFc0EtBtBp5l24gFqOEHj3ckSfi8iTUMip8ivPXqhf+1lMwGq33CXWq+zd3JYoEvvuEhLrgH4ihKfun5HDUmYzFAu4JFzj1mgwHSNv5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHFKM0kxZmtYay9oOGJiS1FpZmN6ZSttN2JIdXIwdTd1NVpwaW8vRHNhWEc0?=
 =?utf-8?B?dkN3aE5OZkFqR2YvNnZWVjNKYVZlQWJRUW13WTZaTTNCakcwV3VPM0RpL1Zs?=
 =?utf-8?B?MVFGREd2VVVmMDNOMVBLb09mV1d2bk5lY0hRMFRhM0hxZ2VuK1hzeDNjNHVm?=
 =?utf-8?B?NnZ5SzI5NCt0YWtFQkNWdmVScjBqMzd0MGRkaEZCaFRGNWVvTDl4Z1VuUktS?=
 =?utf-8?B?UTlOOXREeFJWdXQvc1dPTU82bWRSZHZaV1BhZk9wYmt5c1lodmg4UWRKZGs0?=
 =?utf-8?B?S1dhV2lKZnAvZUpIYmIyTFFEM0ZFVk5LT2o4TEEzSE5ValRtc3UzZ3RuenVM?=
 =?utf-8?B?TDM5SVF0MkQzRUhXdEZmQ0J0QVA5Z1lXR3BZNkpqRWIxV2xxSTBwSCtKWVdB?=
 =?utf-8?B?cDdVZlZHRGlQR3UzZDROREZ4SzZoMVI0VVo2c2FGVjRTQTZ5Sy9ybDVQQ3V6?=
 =?utf-8?B?VFJFVzZWa2ZMaHFSSjJhVjN5dDJ4T0RQV3hiR3FwWjZTVFN6M2c4SHNMR1F3?=
 =?utf-8?B?eHdwMThKV3JNTHI3c0xIeS9yWXZHMnJ6L0tGdVhCdGQrL0V5WkNLc3lkTDgx?=
 =?utf-8?B?M1JHK0lORkluNmx1NVV4RmN0ZDB3MTlNZUZ6bXN4Nm4yZjdlZ0p1YU1ra2d0?=
 =?utf-8?B?bDZTQStZdUFITHRZMVcvcm5Ma1RuNGZWZzc5SW1FVFIvMWFNZGN0eTZIenJm?=
 =?utf-8?B?UmdaTkYxK04wY1Fxc0UrL1VibkRSZFJkSGlCNjB6dTYxeUJFeUNlZndEeVdV?=
 =?utf-8?B?SnBmZ0xFN0o0Rm9KM2dxOE5FdmZ6MkswNlNGS3NhdXI3a1FlMjdTbnB1L1J4?=
 =?utf-8?B?R0pPSFprbUpHMnFrYjJuditBam5tVjJ4OWtDUjZEcFhnZjY5K0hBQk9NL2Nh?=
 =?utf-8?B?UmlTNlAveXUveEhrL0ZsT0REV0FDckR6ZkdIenFUTnlsbEYxMlJaaTBOMlBB?=
 =?utf-8?B?ZGZJM1VlWXNWUXJvWUQyT0JjaGFsa1FRYWpBMjNBYmtkQzNHYWhOd2ZjeFl2?=
 =?utf-8?B?UEZja0c3a00wRWIvWXpHcEZWOEt4NmsvcXhFWUhaYWM5Y1g0Q29SZU5ZMkpI?=
 =?utf-8?B?LzFZV1NlNDR3c3NuUEU5cWRMdWdLUk05bGx1UXc5QTJ3VzZwRHREWDBHSkln?=
 =?utf-8?B?MyswbVNvNXM4cTcxb0NZdFZwVUhuUnNJK2xmMTMvZGI3QUxaSVFaanFEdGIx?=
 =?utf-8?B?bDd3ZmwreEExSW9HT3V1bjZPWFJrd3BlQzd4MDNyeWhtT0h3Z09Lb1RtRFVY?=
 =?utf-8?B?TisyYUZoMmhlNDBUV1k4Q1BjcllraUJZb1d3OG5Jb3NOVkRUaTk4QithbVp6?=
 =?utf-8?B?amFKWVRuY2RkV05HWWt4V0lEMzBGYVVwc1l4VkhqSktPWnk0dGhraTlmMVBm?=
 =?utf-8?B?YlUrN1RwOUpVMUNoOFh5ZG0waVVWK2srdG1Bcjh4UUlwQktxVzhrTmxyZll3?=
 =?utf-8?B?WVdyaGNCMWxlbWNQazhvWWNLWU0vczdwcW41RkE5TittOVlHeHphd09jUzhC?=
 =?utf-8?B?UEpxd1ZybGxjeGVzVU1zNVNMUlhWRVh5d3EvQ01Xekhza0l0d1l6enIwV25k?=
 =?utf-8?B?Skt4ZS9BWkhmcURTS0JQOWZpOEsvZExXYWV0SkJEWWxTcklGdXJuMHlvbUp4?=
 =?utf-8?B?czFBTXB0bUR1YWNVN3gwZzZZblZWZlIxZ1piYzlYY1RkVnZ6ZW5VaEFna1NT?=
 =?utf-8?B?Y3h2VXo0UmNyVE1LTERHTlI4eHBXcmlkVW1wNEQ0RytwN2NucGx4eWdqOVQ5?=
 =?utf-8?B?Z3hXWkNxbi9sWDhJbkJ4S0FLUVE4aXRzRER2MHFSaVNHWXpXd3hnbDd6Y0F0?=
 =?utf-8?B?NVpxRmFBUGNkdk9ZZlRQQ1dBQm91Zkl4NEtLV2NDYndBdDhsWUY0V1VvZ2pk?=
 =?utf-8?B?a0p5RXRzZkJ2bXYyQURlcWdrOGFyTU91Y3ZxVEJJZ2VrWnJzWDhVZmd5MU8x?=
 =?utf-8?B?K21HVjJ0dnNLd1dQaXpNSElUTHFMSk1uckJxVERZc01KZm5NMmZ0eFdWb1hx?=
 =?utf-8?B?dERDTTRHaW9hbGxKS0hHdkJOaTFIWjJxUEFCcGwrd1ZxY3kvQ1VWcll1aGdx?=
 =?utf-8?B?d2NBYkVhWVJodVQzSHBoOXNjRDlNK1J4QTFTZmRFdUQ4Q2NIclpGMDMyeWpZ?=
 =?utf-8?B?L3RZTHhGOXhVZnZuNEVaTEpTOUM2eDhQQWp5NmZMa0pNSlpGQUlnNzNQcmJy?=
 =?utf-8?B?NHNncGs3WXJMQmI0dnp5cUsrK2d0WmEzR1VyWkxZL3FkM1ZRSjVDWW9FSW1H?=
 =?utf-8?B?MVY2cDRzY3hmTjdxVHl3eWZUaTBra2p5dXJnRVR3N0lXYnVMYlF3Rk9qc0FN?=
 =?utf-8?B?eGZoNHZGOFB0N2F4MzVtdnhZbFF6cStkcTlia0l0RTFoS3drV0NscTZWeDRC?=
 =?utf-8?Q?5yi0xWiqJwr9kAmk=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9017d2a-0702-4d92-6018-08deaae4b38d
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:27:17.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZx98+xhb2g/k46MCxO4vp5KNLn5EasJPhvPawctPl33R5lwCq4pnp8IuY++bDeIADttnp0yx6QQlpSjP1nNeZIyiC5Xed5ZDC3dUVEuBUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8322

On 05/05/2026 9:20 pm, Maciej Wieczor-Retman wrote:
> On 2026-05-05 at 19:30:21 +0100, Andrew Cooper wrote:
>> On 05/05/2026 7:04 pm, Maciej Wieczor-Retman wrote:
>>
>>> I think you'd need to add another check in vmx_inject_exception() to handle that
>>> DB_VECTOR too. Simply changing the event type if the vector is of DB_VECTOR type
>>> fixes that problem but then the selftest fails in other places (assert
>>> fred_handler_called and saved rip vs expected_rip). I didn't yet have the time
>>> to figure out what could be wrong there, maybe you would have more of an idea :)
>> #DB is intercepted to mitigate CVE-2015-8104 (systemwide DoS).  But, to
>> start with, check that the test passes when #DB is not intercepted. 
>> That's the basecase for architectural behaviour.
> I take it you mean dropping the ICEBP selftest test case and just checking INT3
> and INT $0x20? In that case the other two tests pass after a minor change -
> namely in guest_code() the expected_rip needs to be volatile as well. Otherwise
> there is a RIP mismatch.
>
> Or did you mean I should check something else?

The selftest is correct AIUI.  You should be able to prove this by
disabling #DB interception, and observing the test to pass.

Then, there's a logic bug to fix to cause the test to pass even when #DB
interception is active (which is necessary due to CVE-2015-8104).

~Andrew
