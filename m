Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8235294E;
	Tue,  5 May 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777943662; cv=fail; b=eoT/ErTeXfgyPL1FS/Owmi0pd9wOtdjKANELPp+ypTboHDkiiKyExhkZKTV1YmfIUiSw2adliU2Oo5LuMxlsYXuvj29MWxPE8aG+iSr4ddU3IInf9k/lvQakP+zhGUreq1bcU6BOeXbWBRZuUI936BDz8CArYT3S5OMPp0d5fUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777943662; c=relaxed/simple;
	bh=auZmGAQ3S5IRMxEOR3J3X0NS8ny7USrpxfx9psnNYeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4L1TgOLPx0TK13QIW2HUHozg6g0f/pVlXQOZXAQYZEWv+G+rd/nRFHHVeT/MnLoefDDxnBzn7tkcRWNmYcgnjr9rRP11GJj9n3D6PqyVcYxpiKZhVGu17vkJ2UwpS/LpomMM7rIi6/zyBjwimtONjrxjd447PnK83wPxngFpzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=NE1btyL0; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Bk1t1fc7; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="NE1btyL0";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Bk1t1fc7"
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Kn66m2953960;
	Mon, 4 May 2026 18:14:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=auZmGAQ3S5IRMxEOR3J3X0NS8ny7USrpxfx9psnNY
	eI=; b=NE1btyL0EWm4sBKUFR4oIbG4oRX4uR7IrGrwjZ7I7vAOZGI+NHPWS8TeJ
	vzQCn0LZYgdG+RXd33V4uDgTCfb/YTCuakh7Fm5xQhnVMXMPzHWb6VX2CIG6AkWG
	qicty6ZxGdPzNf03zrRucH2VufHL652JjjTd47n/49mIMdrpuQUo2bJbiWByEvOr
	KGh5lkTqgf7bdvfsF2RNGhXKkML50rf6XyqILO70mUbYjBn1eJ9bsCXSTnLteszE
	HvKRR29o5RvRnii8OVPNftwLGFYM+raB68XnWTNC+vf7O4kiGWSwbP5j1bFuSSYc
	zvtJOQY9dcnpEzbr6DMp8FQQcjCKg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020078.outbound.protection.outlook.com [52.101.201.78])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dwgsy4tw1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 18:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2klw9jD4Sq2VvUb/ZIpvmIXCyIXW4oZdv3FllM//COKceFfBFlU5gpKbBpwUu+pL+hQaTRsCGZ5rX8e/2tQt3QBq6nGbFtWLOmnFvFgLVfkVn6pEGT2H5/abeyHceeERziQCvF4xbMvhLlHqR9PDi4mww5vSbp5JRnYxHfOjVc3x3OKgotR7p7EEQbiVF+AlqzM3bxCjdDMJbh8U3dbz6mGFhCZS1uWKKwnSoXAfO6ksq7Cjh9hLw/nztf9dheQKZzkCLOg4cOv6wFhpWVqnU33KmmM9TEtlbJEsuMGzfHVh4FXuZQVhfXjFgGTXh7c9kLR/0kaiN6I8SfiHBoboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auZmGAQ3S5IRMxEOR3J3X0NS8ny7USrpxfx9psnNYeI=;
 b=IFYj0ncBWAJi6tjq6c3wotbjiWKgHaWGhmMTU/rH7xZb00fqgQOGCCIl/hphGXlkHf/rXziFOwA2eQbDcTMH/OlDlNrXtaBrKO1m3F1kHgrHPEk9bS0wfqSfF7WE1uJEfa2RuKN3izMoRHRU1zFrNbxGP01WfNOaZa5W+4Q7PdXgxT8xF3kaLGgf3TzK7ftWnDJRkZDvG2Jo0Dm7U1Xg6uI+WkYCW8nD0R3Fkmxz0UY7u2es4sB57uar0t6OJ7THR69qjoizHRlJprml/rzBLXjBYRz3WRMCxizbdvnmgPVb+MoNHDkiIMvRfXEPvNvi4tZgHgWm8Ql52gwfQDOOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auZmGAQ3S5IRMxEOR3J3X0NS8ny7USrpxfx9psnNYeI=;
 b=Bk1t1fc73gYZiPymUd5ZI0xgCfH2V/JsFLYNzjSX/cW3HreKz44lM0aDk/c7TdHC4Y5qnMyFkSglrXB0IwEA93372BVPyDnWsnGWqrW6+iFzY+t+NryfzzA4KgyYlRRq6qQB4azyoiOtGxiDnosWwGr96tbhTNWhEeyMWz634C9HA/zxrqJfkfBPXDBPK23dq9UgE+3tp6dpl/uzHpdwWeeHw27icnPxKf4PxJFvfhnmBhERyi+7dnzQJYFMa0q7fLgnhmDcWGcTECo5nD7tXswn5ARQvmNkMBWPYhinUG7QPATOAetBYpRmVHbJ+VCH/jxsuwF8WnwbDeT3pW34Eg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7672.namprd02.prod.outlook.com
 (2603:10b6:510:4c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 01:14:06 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 01:14:06 +0000
From: Jon Kohler <jon@nutanix.com>
To: David Riley <d.riley@proxmox.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
Thread-Topic: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
Thread-Index: AQHc1v+KYoqyIsiSNkCgS7/zDVrdnbX2A8OAgAFmbwCAABvmgIAHJMwA
Date: Tue, 5 May 2026 01:14:06 +0000
Message-ID: <90DA3B4A-633A-495A-8118-90BD26744230@nutanix.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
 <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
 <CABgObfaFeK4kJpMGuki2hQxnz2ij8Nyyk0egxEfW4b_OYf9hgg@mail.gmail.com>
 <1a7c35d8-d7fe-4eec-ad83-da92780b62ce@proxmox.com>
In-Reply-To: <1a7c35d8-d7fe-4eec-ad83-da92780b62ce@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|PH0PR02MB7672:EE_
x-ms-office365-filtering-correlation-id: f5823e86-b44d-4d19-2397-08deaa439aa1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 OWACoFs0dEwXny5NNBB/NhV82rqiwOXZAMgFa5lQGnJAQZ7BmxedYka4lOZpOL8zlLPJubqmgfGaF9jeEld/eFh/zL6mG5SEk9DxH+2ztYg2djWFXcRN2Our7evjgpjFD0qta1uxy57P3JUsJJvFCRngy9tE2WpzBohDRGBe6gF67cTT9sCdxtnT0TsHLnJL0/lkatAlAC4P+t+5YfUWwM/EhLOiy7YxoFgm1JVIb3SHjNZc7HMvJCuAMFsgM5iYUUprq5cWatK6X/LQfSfHb+tEaVgr7Hrkz4yiwAIWhf8rZClcGcZheCHuyEiJzQthc2EcyXudJ2ibNhrcyfH61X17UbPPZsz9oPyPGm7SrNeus83Tr2LezW39PuOqhNz2UwxJkX7xJadawTilusMT+r3XWsjj4KWbNARpokBr1ch1LtaWZfmav6/zkSyTlRY55SzurIa/lsgVKadaaWMrwJsv4+ad3Xx+Mb9GIxqsKVeijVWJ/GOuuGDaG67zaxtvop6cSJ7PENqdA0qN1zsUFRjU/lROkl1wAj7VA5mHjF61/A8W90iB5EHrQ7YR8ixfaU9i1ClFNfyWWeByFTAIywx6R6rlIAHv8P9zXbA4AhEq80nhj1U0sL/Df0q5c9dABLX8ZGKROYAsgkHu5K6oVayZBywvGdFG4TdkahvxA3QhkisOYcKMQwLIvfhmrIbL8vYqed5zph5T6R4nQgIPOT0HO1kAusB8E76vDHS7YmOa9Jih903Lns7qqI7pKWvR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDNKbW15SUkrTE0wQmJTMDV0S29qb3BvTjcwdm9vR0JGdzBGYzBGSzU2Q0tH?=
 =?utf-8?B?K1hVN2FwdWtTT2pUYnd3STFMczRrR3NYVkFFKzE2MDRPUlNnL3RrT3l3Vlk3?=
 =?utf-8?B?WHc1QXc3d0I5MDY4RUh5T3VOUmY4RWdGMkRuT0FYTVp1VGRBcTNBK1BybWpT?=
 =?utf-8?B?STdFeU1VYXdxNmNMbVArUGIzc21jVlFmMkFUUzJBc09QeVh0bFp5alA3WVlw?=
 =?utf-8?B?MVQrbWV6MlVoYitsSEg2azBvb2tmWHR3YXNHMGFQQ01rS2Rqa3ZIK2V0Tmwx?=
 =?utf-8?B?aisvQytjSXVmdndtUGt0RFZEVmZsQW1lbitaNFlvR0lOY3IxYUY2Z3V0d3R4?=
 =?utf-8?B?N3RqMnBiQlAwamtnSVprdVFQRjYydkJPZTdib2pNMGlBeWNiT3VwRU1RQk52?=
 =?utf-8?B?dUZ3aEo1dzNjc3lyK3B4by84UjRFbndadmR1RVNmM0JScXhoVG13V256dStr?=
 =?utf-8?B?czZLMjRJd3ZOQkcwOEpBZDJwUlMyQUFtZzdkaXlITElBN1FrVjk5RG9qbjgy?=
 =?utf-8?B?eVRyWjkybFRsREJ3WEhnTG45QUNpUURpVlB1Yy9DSFRUa2F6V0ova3NuSVRi?=
 =?utf-8?B?YmxtRnJQR3lhZWNuOGlYcWwwaTlSRlAvY1JQa251N1c1SEJicTJPZm0rdXJZ?=
 =?utf-8?B?MWEyOFJLVnpuUXEvcjVLdEtLTFJ1U1dsVHM1NGs1TEIwNEk3WTNxaVdJWmRO?=
 =?utf-8?B?MkZHNkNpM2RObW1CUk10djhPUDB1NlhQelVEZ0YyRWxjeTNkZzFxek95b3pn?=
 =?utf-8?B?U0hnRXIyTlVWWmo4dnVWbjhjb3lZZ2VIWGZFVTdHbXU4bnFZcU9CRGlPQWxG?=
 =?utf-8?B?ZzQ1a3RuZVozV2RrQXVRdGZaUkFrbHh1ZnB0WHNTME90QVdjR1kzSG1JNmt4?=
 =?utf-8?B?WkNCOStucXNub3hrYU1DSXltN01Cd05ySHFiWUxiQ3haMjZwV2x2dnNGVkFW?=
 =?utf-8?B?VUI5Tmt1R0trRkkyNG55SjNXQ2taZWtLZDdoZmI2cmpSei9qWkZjek82RHZX?=
 =?utf-8?B?SHpCcGd4UjNlNytuYTA4VDdMYW5KQXpRbkhBVHZNbHBLNkRrVHBzM1FBK2Vx?=
 =?utf-8?B?ODRrcExqazJKMGJxWmgzVnQydjBrSlV5Mjh2bnB3cTFtWnRvdlR4VDhScXdk?=
 =?utf-8?B?RlVZekdPSTk3UzQ2dzZhL2VjQldnRmNrVUNNWmIzNVZQSjh2dGlkL2NRWHJs?=
 =?utf-8?B?MDlWZ3BOZXg3SEw5NHI1WXJJQUVwYVI3UWRMM2diaENiV1ZISU1BKzVmdjNJ?=
 =?utf-8?B?NXVpeS9GNEhXTDlwRWt3RGRrTXprQUZNZVBuaVRQZlFmeHRaSGFNUHFScmN0?=
 =?utf-8?B?L0pZbFE4dFQ4VVNOOXZJeUdPVEpZUHJXWFFKQnJ0cW1VYlgxN0txOXYrNFdL?=
 =?utf-8?B?ZVRzQm40MGJTdTNHdFZXMlJlcUcrTHZ1WUpPckN5T1ZIbEF1K25rTFFjS3hB?=
 =?utf-8?B?MDYwV0NtSW5ZbTZHeUhDSkMzbDZpTU41Ti8vc25nVko2TG5hOU5lZUY1UzFY?=
 =?utf-8?B?eHFHQ2JLVTJzdlIvWjl1RTJrTVA0RWhQUHd1emZ1TEk5QUg3S2tFc1o0bnM3?=
 =?utf-8?B?ZzduVDdQVjh3anZHbGxVMFBaYWhxcVFFNzhJbC9LclFVMFlnQzN2alNvZFQ5?=
 =?utf-8?B?dUozTUxBVHJDL0gyT2loWnJjTHlCSUhDTUU5RUUyMHR4aGRrV2IrUTlaOHJ6?=
 =?utf-8?B?MWxxT2ZPYWFpbDlmamZpTVpXK0wzTFNsSWxIVFpuVmRSSWFwTUJGcitNSHB4?=
 =?utf-8?B?b0ZNU2VQTlBGYkVCYTR4TXhsSWJRN2dkTTRvMW42RFIxYkFYeERTNFdTNUts?=
 =?utf-8?B?dUhvaVJkY0YwWGdJVjBMOWRhb3VUY0ZyaGdqc3ZzVDVVSmlOMm9jMUpPWGJm?=
 =?utf-8?B?Z1dxb3lDN3g2VngxbWNESmRyNmt5NDY4NUdWM2ZtOGxEU29nUmk0a2V2TGw0?=
 =?utf-8?B?d1VmR3Z0V0g3ZXd2U0ZSRTU3MDNtTFFDYlk3WTZwK1ppM2tvMVAyTlJKTk1X?=
 =?utf-8?B?RmRtdXgzaEYwRDBCT1ZiUVo1VVF2SHZTcjJTSldFR3hRSmlzZkt3WlA5S2RT?=
 =?utf-8?B?d255RDU5ZExkM2dRRXhlOU9xKzFvYmYzb3RFbEhlc3oxZXdGVTJLSUY5Wldi?=
 =?utf-8?B?TmpkamR2d01qVUVXajhZeEwreWFyU2hZVHJxTFRaMEg1c3RJeVNBZk1nQ3hn?=
 =?utf-8?B?VnloUzlHSTFOT2FWN0F4SjBrK0U3UGRKNERTV1RVcFF3Ui9iYzhZMm5YYmZQ?=
 =?utf-8?B?ODFOa3BocUNhT3k5UHZzWXB4Yk9sMUZRL1lpRHFydzNrQ0puc21TOFQ1L3Ru?=
 =?utf-8?B?M0cxTjRvVyttT1RIb2d0cDMrVE5aaU9LNkFYbW5IcVdid3Rsa1VTT3c3M29Q?=
 =?utf-8?Q?J3JbaaW5IHihgw47dmpxIhpYDJe9ar/R3VVQviKWTElGw?=
x-ms-exchange-antispam-messagedata-1: A8l9kI8dIRjrlE85/EdHYoLL45iGXouyw84=
Content-Type: text/plain; charset="utf-8"
Content-ID: <645CE69EE95EE8419FC2B4EF77D2FFA0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	B8n5RuAg2biTouirhvofekpOSJmA5YYl7JqPTtcmRQtF81VNrfh/a5ge3GQXUBKBO1kjL7LznfEGNNUxXvMEb5ERmgYevzFsXe4xy0Fp9RKBjtZXFUarsu+0CjAPu6f9Bifqre1YFwK1fzD1mBfArSffkPPUQpiEv1DHR+CuC9ZAsXJ7nkSPqJTinT6VqKAC5GDT5HH84/QvrFhJOZxp1yjXoAajtpnvGTRffkYqapbdqyuXoF8DFt+Y2103VYrQcptTtUdv8GY8PFTzsS+4UEXsmwzbt0PxHglL3ZnaE9b0cwKtnArc0uledfGEbC0wxlgOGIl58V79D5CRtVcjqg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5823e86-b44d-4d19-2397-08deaa439aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 01:14:06.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VItj8dOYdKXiV/Ntd+eYv8Ar0FvDPgBSK3BOTUS0kECDWfahuTgKCSIH/kZpkxpkgPQb+Kzkrj+myWBIbCMvKXbFjYa+jwKuBNugomv12kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7672
X-Authority-Analysis: v=2.4 cv=E+T9Y6dl c=1 sm=1 tr=0 ts=69f94460 cx=c_pps
 a=liVm50ALzK+Uh0u2J7W3cg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=Qm8iP6mkAAAA:8
 a=ZnRs6QBsEmFVO3zsQpEA:9 a=QEXdDO2ut3YA:10 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-GUID: HVKg4jPMLm4gGJHOCnhAX60H5k_aW_zN
X-Proofpoint-ORIG-GUID: HVKg4jPMLm4gGJHOCnhAX60H5k_aW_zN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwOSBTYWx0ZWRfX5aGQ/A5oYGWo
 71OIGrH3LkE8BbeXqBRR6X+ZIFPSQyztBhAihCAVse9zAezDU/9X7OEp/pORjhFztyu2TmICNEM
 QqelWGLPskF28BGMb3aKJBk1friuh8vsAp2o/gq3IdxskFNk5vlRl5Si1abqn+ollwZxdhlou7N
 EODdPMbIiEUuQpzfDlskl+oaTQgK1AMG3o27CFgKPyHKiGN01bD9xfAV3B82AaGv7AAycVjQu/h
 KM0wHjoNhiLyXbcjpATUbDQM4wnO1UvuDv8UZUl03l2LWCmhgbDkcoLdk1I49BwFI+siVDZginM
 nmMFMkC+UbJmW6nnam0zd04x9Vw1MhCsAQazpIzl1loduTtbV707LN+m/9j8dUphzD0l2ZBxPCl
 Rf9zwPLqAPACOP9/XigwxL6LH4U67QqpdqnCqSPVigKvyQjnwBEI0HDU0YydOMRNn0TIqC7RE+i
 OGNzjGt9+8wpLKIWi6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDMwLCAyMDI2LCBhdCA4OjA44oCvQU0sIERhdmlkIFJpbGV5IDxkLnJpbGV5
QHByb3htb3guY29tPiB3cm90ZToNCj4gDQo+IE9uIDQvMzAvMjYgMTI6MjcgUE0sIFBhb2xvIEJv
bnppbmkgd3JvdGU6DQo+PiBPbiBXZWQsIEFwciAyOSwgMjAyNiBhdCAzOjA14oCvUE0gRGF2aWQg
UmlsZXkgPGQucmlsZXlAcHJveG1veC5jb20+IHdyb3RlOg0KPj4+IEkgb2JzZXJ2ZWQgdGhlIGZv
bGxvd2luZzoNCj4+PiBUaGUgZ3Vlc3Qgbm93IG5ldmVyIGFjdHVhbGx5IGJvb3RzIGludG8gV2lu
ZG93cy4gSXQgZ2V0cyBzdHVjayBiZWZvcmUNCj4+PiB0aGF0IGFuZCB0aGVyZWZvcmUgZG9lcyBu
b3QgZXZlbiBlbnRlciBXaW5kb3dzIFJlY292ZXJ5Lg0KPj4gTGFzdCBtaW51dGUgcmViYXNlIHNj
cmV3dXAuIFRoZSBvbGQgY29kZSBoYWQ6DQo+PiANCj4+ICAgICB2bWNiMDItPmNvbnRyb2wubWlz
Y19jdGwgPSB2bWNiMDEtPmNvbnRyb2wubWlzY19jdGwgJiBTVk1fTUlTQ19FTkFCTEVfTlA7DQo+
PiANCj4+IE5ldyBjb2RlIGhhczoNCj4+IA0KPj4gICAgIHZtY2IwMi0+Y29udHJvbC5taXNjX2N0
bCA9IHZtY2IwMS0+Y29udHJvbC5taXNjX2N0bCAmIFNWTV9NSVNDX0VOQUJMRV9OUDsNCj4+IA0K
Pj4gQW5kIG5vdyBuZWVkcyB0byBwYXNzIGRvd24gR01FVCBhcyB3ZWxsLg0KPiANCj4gVGhhbmtz
IGZvciBsb29raW5nIGludG8gaXQuDQo+IEkgY2hhbmdlZCB0aGUgbGluZSB0bzoNCj4gDQo+IHZt
Y2IwMi0+Y29udHJvbC5taXNjX2N0bCA9IHZtY2IwMS0+Y29udHJvbC5taXNjX2N0bCAmIChTVk1f
TUlTQ19FTkFCTEVfTlAgfCBTVk1fTUlTQ19FTkFCTEVfR01FVCk7DQo+IA0KPiBhbmQgd2FzIGFi
bGUgdG8gc3RhcnQgdGhlIFdpbmRvd3MgVk0gd2l0aCBWQlMgZW5hYmxlZC4NCj4gDQo+PiBQYW9s
bw0KPj4gDQo+PiANCg0KR29vZCBzdHVmZiwgdGhhbmtzLCBEYXZpZC4NCg0KUGFvbG8gLSBBbnkg
Y2hhbmNlIHlvdeKAmXZlIGdvdCB0aGUgbmV4dCBzZXJpZXMgcmVhZHk/IEkgY2FuIGdldCB0aGF0
DQppbnRvIHRoZSBRQSBoYXJuZXNzIG9uIG91ciBzaWRlIHRvIGJlYXQgaXQgdXAuIEkgd2FzIGdv
aW5nIHRvIGRvIHRoYXQNCndpdGggdGhlIGxhdGVzdCBzZXJpZXMgbm93IHRoYXQgSeKAmW0gYmFj
ayBmcm9tIGhvbGlkYXksIGJ1dCBmaWd1cmVkDQpJ4oCZZCBhc2sgc2luY2UgdGhlcmUgd2FzIGRp
c2N1c3Npb24gb2Ygc29tZSBmaXh1cHMgd2l0aCBTZWFuIGxhc3Qgd2Vlaz8NCg0KVGhhbmtzLA0K
Sm9u
