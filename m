Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5A2147F9;
	Tue, 21 Apr 2026 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776738167; cv=fail; b=n+FNaIiSMeLJQ8fuXwqJdWlcH6sSh3KCkaStkZZ3AMLLZfd9YVh5LzF/JIv9kwRkvmvb9N+ze6vDshnLVVRTASJ+pims2ahE0cwqq7aoZKbjTacCeQK5GtRGW/VNgYsUozge2Jxx6byUrNT6XVndba/ZtWHvk4hpUVcfclR73gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776738167; c=relaxed/simple;
	bh=o0T2LHl+L39XDxhKcpwULWYChml4oSNsh16MmVKOxOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EmmxdEWhMHxiTyTmbouYG+spf1cBzrqNf8SQlPt8L1LBnKqMzuoxUimxBqnlSWc3qukHlTb7bLAeiq0Kk4HLdHB6tGacFHXz39AT94hYmmxJj5VVMLNInNyQc3ZsiJWDBA57gHc94FnvrNz0VdvF0xEL/gW+ZMv9bdIu/E4mX44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Vs1ErqBf; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=bBQro6YS; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Vs1ErqBf";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="bBQro6YS"
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KInKxv1888601;
	Mon, 20 Apr 2026 19:07:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=o0T2LHl+L39XDxhKcpwULWYChml4oSNsh16MmVKOx
	Ow=; b=Vs1ErqBf3dz6N2bxtHcnvULGjpJq7le2svR9vS+KG8hdMssZrq8m1fK5V
	OR3MF92X0rTZieBMddOB7NhkCWh6Ylta2Q/+39ArIsn2VCtr3j5aIupuYdQ43QSZ
	tNUWyQsk0pXf+GFzr/1URUVO+8tMaEGkyZMwAZY/WakSe2xCHhnHZOEPi/OTCAch
	wXvfOb0o9ifKd1gUyluQopoDhUXWdl3s9z9YMCSP0G9XkYM6Oi/mnjwt5K18jXnd
	JPrk0owKv/gCUE8Hk9QFzG1CX1V/DYG+iI6Sj2RzZR5TeJL4zExflRnKPRdze7Nz
	PushT6ZX1JJ0jCRNIvPw7bnfqHp2A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022079.outbound.protection.outlook.com [40.93.195.79])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dm82gcpfe-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 19:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu4yRMtT4xJOLyKjafBZVkHtoK/fRELdfpXAkjRjg7JSI/5dWu8r1e+7P2z2t5m300amUHDdyvTh+EpSobf5ooexXfiA2N4cZeIzwYxpkAbAOi4/bGQgzs7HZkqmatrtlDhBaHPO/hjL0R3K9DzCjg07zuOSiJi49nqdzqkvnt72q9HvWpEk2m8q92kDM3m+e3RWyQNDu2eG9EdOe7gd5Lo+pTj5jvA9kAmBgEv99F1S9b6RSk1hYswB0NanuROL1S86KzskDJYtnBvglXZuYuMhJRI08T/wru9JmZnksYaiL+xaPT2f3McFJP3YAvVSawAcl+6oaT24jPsrODyjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0T2LHl+L39XDxhKcpwULWYChml4oSNsh16MmVKOxOw=;
 b=XhnAG3lNagk1W6eTWpt7gUxk1OaC9mDUvmRJCtw0jz2LtkbS2ihEJXfhq1Lx1We8VTB6kYTLQvXQoTXNq7iN3tW3qEi1/3S/lTzVRGubPyG/AlgtsiIzMO1eSjxHYn+TF+GF3S3vwj7BS4KJaVppNqhSjuiF4ilIS3OhRItmEgQD7pfJUNoVWLTKt7ld4y/j0zlfxhcZTu7trAGO3DGBxaFIb00wxXKnNqLYs3gtX+S4TOGsFSSNbtO6dlFMGhV+DqP49+Av/LnYhKqEcssnyhnNmJIcKJGRMSjiX+DwtlCtM30POFMWkvD48NBqwIpFJ2daOFGWbwOQhcW6pWnEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0T2LHl+L39XDxhKcpwULWYChml4oSNsh16MmVKOxOw=;
 b=bBQro6YSNWB+uiMWkbO9QV/kJEqWe1mziHU/HUMwcMLpZyQAx5leHpdR7LiPM6YoUFuN4JROBOiqYrhjAbwJWaYjBhw7NjYeM9YkoIRlcO+MFpp2MSzafZ2Q2Bq171wRmsE/le4U9OlwDuU26eUPj9MpL4jl91NHBuVu3tY5AxKD0yWjIFMUwOLixsVUzxz+J6W8ygr6Bl8II0Yqa7e+HxBsGimK0gyEQoFAnobVwi7HeM1GesIFyVS/I5sTmdxOFv7+zOhwCocYlwf2TsuQbnI34JDMCsw+LJam7xDlJd8RyAy4G+yXfyR/gCAthdImZbQDU9KAaZVcSjmxs9jEEg==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB7636.namprd02.prod.outlook.com
 (2603:10b6:303:b1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 02:07:08 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 02:07:08 +0000
From: Jon Kohler <jon@nutanix.com>
To: David Riley <d.riley@proxmox.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nikunj A Dadhania <nikunj@amd.com>, "Shah, Amit" <amit.shah@amd.com>,
        Sean
 Christopherson <seanjc@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v3 00/27] KVM: combined patchset for MBEC/GMET support
Thread-Topic: [PATCH v3 00/27] KVM: combined patchset for MBEC/GMET support
Thread-Index: AQHcx25R3mo2U9XAeEe+oLpYjb2tcbXfvf8AgAkaNQA=
Date: Tue, 21 Apr 2026 02:07:08 +0000
Message-ID: <818FF8AD-9DF7-4100-AA46-6E84253D7B72@nutanix.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
 <c91391f4-57b8-4bad-aba8-2c47c285ab27@proxmox.com>
In-Reply-To: <c91391f4-57b8-4bad-aba8-2c47c285ab27@proxmox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|CO6PR02MB7636:EE_
x-ms-office365-filtering-correlation-id: adca07b7-1b25-40f0-3e0f-08de9f4ab17c
x-ld-processed: bb047546-786f-4de1-bd75-24e5b6f79043,ExtAddr
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 xIOxrRUPAB7cxehrnDeBDOrL8j+WGgnTleus2IZ1f+peymz7ViuTxFBP3BesZ79p3hgYgM2vAfzf2TI6dXrD+1feTC8rgrPZLSeOdIy4edpZ5vmBfgXVGBXY6gJnsL8Aa7Wi8m3q/5ekGUq+98PnSOloXakU3K/peD009yr4ENOb8DnBktT9wt5UUGgeXpgEm4MhXW8iA4znLq9HjdQUx8vqXVCEv19W2lvE2mz87eGLUrVk+3w8w+k5waMtXuscq83zW8UY482kSzcRHWwqvFnT1VqlcM45CNQjncrGaYTjwhE87P3F1n5O5jSVaXuHFEkmqT9rUgvIXKI/meslSSj0xnW8sF3/Ty1x8qxpWwN6yNlPy4yZAMpM+Vp95kbCCNMS7t5glmTN1c2LGW/oKWHG//ILuDWsH3CWdyzemL5rHM9Zd5Kre2urQB+xWBxNeX4Aw4LNz+kN7Bo5nqyVPyDEpmhbBsTCodumFRnC/VRfT4wbZqalz3ny6URYFocQRlcBHuePmELJZeivNJR1LKlYo7NvRomx6oEhVJ4Mzcortb1ifcCDFjbXIxXg4l5bnhWtVPOrqk1OUeztVzd7N5/+O6kRv6zLDdGkF44hDaHRqg6Qu6Uh68haTQKIULBtjK9NDEijYjzlo8wAVWOx6N+E76nqm5eqY3VXNdJbe4MknAX+kPvzs7SbzcBX7rz0ZkFHkuyTajrbAg0WFpS02CggXWc+5564OKEEO5ijBgp8NGYZryQnvtrobSHKemMsuA8dNQ8Bs+a5W9+cB9MOHQ+zkOQ72kuI4ylyWTIA8xU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2h2aVhiR0VsOE9NaHI3V2kraVY4RGJWekY5RjZ0REZUNHZDaUd0dDRJSXpG?=
 =?utf-8?B?ZHhtSDdnWjlDa3JFODlKVkdVdUN6OGlYUlZVblBaRjBOZjBLUDFDdjRHd0lp?=
 =?utf-8?B?WjVCNlJCaHlxZXdlUktScFkwMVdiajBGK0taV1RCWllsYkRQN2hKaklaR1FR?=
 =?utf-8?B?c0lWQ0xDUG5qRVVpZ0I4bmtZbFM3RVFrTVFVV00xRitDZ3V6c2V2ZzhlazNR?=
 =?utf-8?B?ZXJoaGszL28zWHk5VW5STjJab0EydmdRc1E0UmlBTXpCVGp4ZGcwM21mZU0y?=
 =?utf-8?B?VVpHNHQ2WTJod3NoUWFiVTR4R2N2K2J5YlBGNTA4WUp0NWpBU0hvNGdUYjRs?=
 =?utf-8?B?M0ZlRjJPY0NuOGFxNTdBN0ZUMW9aRVFrejdNWUFmcW9BRUlpRzJxazJqRUJR?=
 =?utf-8?B?dktNaTJRY0FaVyt0SW9KdlM0VVVyMFBDUFpCZGt0NVM5YW0yZXdGRDd4dS9l?=
 =?utf-8?B?V0xqb3llWER1ZDMrTnJ6MmJFZW0raFBYNk0zTFNyQnFaVFZ3dVkvalNJdHVt?=
 =?utf-8?B?cnNDWExnVlB5YXp2ZGp2M25weCtHa2ttVER1YWozQjJoTWxCdVMva0JMVU1q?=
 =?utf-8?B?bDVhQ2w4eENwbTRqQTMxZWc0TjhyVDdVY2VFNWVvd0hvWlBEMXZYN3lPL21E?=
 =?utf-8?B?ckh6bC9jb3FxSk1WeTZlQ3Q2RmI1Z2F1TDB0QnpmVGVLNGhFYTNMUEZuRXVm?=
 =?utf-8?B?eG1KMlMyV0JidzhNK05JNlFwbHNYL0FCNHJjNWF2VnBVRTM5SWRxQ2t2NnhX?=
 =?utf-8?B?ZS9MaWtyeTdFRi91SlBEM0ZxQzFJcllGRDZhMk1NekZaOFA1emRMR1RCcDBW?=
 =?utf-8?B?RDNuVGRKdTJRYXhuNTEzc0liQ1VqZDRaMUZFamZBWkR5K0lBVDJDMCs1ZzVW?=
 =?utf-8?B?bm9oWTdCOVEzY204T0kvRi93eUhpbGs4bnh0Z2FrRGQ3SDZvRW02RDBaQ0lp?=
 =?utf-8?B?dU9OazFOSkNpYlZ3MEJoOVVwVUVBTzRCd3NWZGRIb09kcFA2cTczcUpHN3lR?=
 =?utf-8?B?YWNlYXBZYzBqSWVVamsxTkh4M2NrOE9HVUk5T0JvMHVkYzkxZGo4RUsvekww?=
 =?utf-8?B?aFVrdWZOZ0RQZDltVnJzUXNEYzVGdHdyemVadkdrSnRSTjFWT3hGcUhzajM0?=
 =?utf-8?B?amFqN0R2Z3A3T2orKzV2YWx6bUt4NUI0YlFWZUhQZkMvNjZsVTdldnFHb20y?=
 =?utf-8?B?VmFycWlKVXRVWWc1bnQraFZkOGE0b3ZpUlhwQlBaZDhjTXZPeks0QnhkSmQ5?=
 =?utf-8?B?MkR3ZTY4UnhXTVB5SUlVdU14ZjN0eFpMaEpxRlZxZXF4aXJLbWUwYXEwUjd1?=
 =?utf-8?B?anJNbm9qcy9jTWdDTGE5QU5wcWx0WFpaK0FtVmNXTFpITTBUNE9HSjdSWUFW?=
 =?utf-8?B?NHJyYllOU1htazZ3Z2xFWG9IQVVVSlhtc1V2Zm5ubzRrYk5KWE9MMTc5cmxM?=
 =?utf-8?B?RmVVMkpwVlYwSFo0YXhDWDF3SFRkcWJFdjhFYkYxaTBFZzdPeGRhMytSZDdn?=
 =?utf-8?B?a1NXOTJ1alZubHl6STczWnhLYVFNUllqK1N2ZnF1N0FodHptYW9MeGJWSXk5?=
 =?utf-8?B?NFFZeGtuSWk3R2lKWE9JNHAwR0k2NnJkL1VaUjRQY0Rzb3ZFdWVFK01ETWNa?=
 =?utf-8?B?K09vbnFwa3hXdEJlRmNFVmZ5ZjNwNUdYU2d0UkpvcExzbWpXKzNPTnNTNU96?=
 =?utf-8?B?eWF1cW1jYWVwUWVwcTI3TUR0NDJXVnBFOUJvaVVCSDdqTnN3U0Z3SkVqVnhO?=
 =?utf-8?B?Zm10d2gyZnNCUUwwN3JUVEMyN0JudWJmbmVBNHczYkNjZVB1MnkxTDJITjlM?=
 =?utf-8?B?djFQbzNncG45eEN6US9TRXNCT2JtbXM4dHJqN2Z5cURoeVpxeGV1U2YreGNz?=
 =?utf-8?B?TVNrYWpIaTZSc0FVVUlWRThzQUNPWXhjVmM2azZtV1ZYdFUyMGFrREQxK3Uw?=
 =?utf-8?B?d3RmMU9zOGdsZjZQdG5zRGllcFJ0UHRoNDRWYWJXV0UyWWZUSzllYkN2ZVFs?=
 =?utf-8?B?S0lkcG5FcGtqNzZCeDYySm5NWWVQd3NZK1JaRzhXSWRVZnpLREdIeWdRV0lC?=
 =?utf-8?B?eTVlUnZYTXA3NXBOYnZnR3U4T3IrL014cUtKM0lUS0RpTzYya0l2MEsxQmN2?=
 =?utf-8?B?a1IyRUZnMytROVY5U3VnckdFUWhnWm95QzI2dENFNUtjZWQxbG1KTXlqaSta?=
 =?utf-8?B?OTRvSXo3eWJJL1NrZU1FMEwrMnhzcVYyZDFXTUh3aWRRNVJodnFBbkxROGNL?=
 =?utf-8?B?Q3U2bUM0UjhMeFdyOVhnSkxDSk5seWtRY1R1Mk1BMldTQnc1MkE5aDN0RG5Z?=
 =?utf-8?B?YW5qei8rbDB3Y1lqU1A1SlV1Ry8vOXhpejRrVks1Q0dIM0tzamk4RmxnMGxL?=
 =?utf-8?Q?5Fv46Dzd4QoDJQzara9/FWJj+bkuZzxzfaRTFP9PqWpQJ?=
x-ms-exchange-antispam-messagedata-1: +o2zby+ppmbhOZbzHpfD6JvkUV2n+4m9fkw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE94B3DBA7FB4D4D8E0C5057433BB703@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rN1HU2pegSTW/AbLC22vLo96537/uHjY/QBWpYyqz8MA1swNSHFKp2sKL7LgLK3IcS0U5KTdNppnldcpXXy8AhvtROcb+Uzi/mAWtGhAgH44iPwEGQd80t5Djh0a0L1GiKSp1GZzv21KTN+GoHiDhqM+0HhQKyCh7Yz1x7ySABBmoYzJZgY228s9UBzmmU0sLz0iF3IpOK5ZRi4+cOgQFc/TilqqRUTRJp4HHMMwuDJRCddv8BFZgXAXIe0oc3Qr8Zr5YGnq6mdNOlQmgMnh0xChIDCDAxOB3CBK/+P2f7fdgQ4tevfTeMT53cbds0QUqKZjeWJmM9oabnZ4yJehjQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adca07b7-1b25-40f0-3e0f-08de9f4ab17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 02:07:08.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7nsxQZBiukegB7hXng/elkPsNDHzA3vO7lhb9wT9YoMGIVvw/Ms7FBiG3ngljRA1VeuFDZ07GkUj/2MPEkZdakz19mFYKNiTH/OXmtS3MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7636
X-Authority-Analysis: v=2.4 cv=Q4ziJY2a c=1 sm=1 tr=0 ts=69e6dbcf cx=c_pps
 a=ON2AtRasCbt5Ww1V1qMYlA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=Qm8iP6mkAAAA:8
 a=4UdskPbJaGk5poTIj9IA:9 a=QEXdDO2ut3YA:10 a=kDhhxE42lZnxL3pOKqYK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAxOSBTYWx0ZWRfX3aORuzuytQPQ
 fLcgYFvpySn05OzSxY2nZOtZBcq5urgdI542TK877jAmNBG4TOuEDgfru43DXhncblA+XTTkVzv
 HldlTiDFJXH7ENZXaCv2+2bNw8c5zKfYIR0bfdZuh9iKm4hyXmHQth6YNjuvIPj04fXP1/IgO4f
 XhJPjmz6771BFaDq1NYBPWyIlHwmYtiU9FsM1TEdMhTbNiWXtCaOWa7juX1/+cnRY1q4twIGqHY
 hP3UGQvZvc8E1iMYBmMRpdD2m5V0Stu9qV9jEDMlz3t0DzRUklwLFiO7E5ml81ebrJtVIIMr9PC
 u5aKeB1MdVKLzxWde95lKJ7BZvbEqXqBHKM4ef0iSGhJLYikqLiEtG+IODNcv1pMjkGkpOnfjAY
 w80vTnhVtl9B0O032KufFgUwr2hoTLOTCsFyL0QOElw6jXZUcl0l3TQek09z/l8iCWhrt0L22NA
 /+qrC9o90CAEE/+yz0w==
X-Proofpoint-ORIG-GUID: 5vVexdjAyKbE--XVTha5f7uZvWR23QGM
X-Proofpoint-GUID: 5vVexdjAyKbE--XVTha5f7uZvWR23QGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gQXByIDE1LCAyMDI2LCBhdCAzOjA24oCvQU0sIERhdmlkIFJpbGV5IDxkLnJpbGV5
QHByb3htb3guY29tPiB3cm90ZToNCj4gDQo+IEhpIFBhb2xvLCBKb24sDQo+IA0KPiBUaGFua3Mg
dG8gUGFvbG8gZm9yIHNlbmRpbmcgdGhlIG5ldyBwYXRjaCBzZXJpZXMgKHYzKSwgYW5kIHRvIEpv
bg0KPiBmb3IgdGhlIGZlZWRiYWNrIG9uIG15IHByZXZpb3VzIHRlc3QuDQo+IA0KPiBJIGhhdmUg
b25jZSBhZ2FpbiB0ZXN0ZWQgdGhpcyBwYXRjaHNldCAodjMpIG9uIGJvdGggSW50ZWwgYW5kIEFN
RA0KPiBwbGF0Zm9ybXMgdXNpbmcgUHJveG1veCBWRSAoYmFzZWQgb24gRGViaWFuIFRyaXhpZSkg
d2l0aCBhIFdpbmRvd3MNCj4gU2VydmVyIGd1ZXN0ICgyNEgyLCBCdWlsZCAyNjEwMC4xNzQyKS4N
Cj4gDQo+IFRoZSBmb2N1cyBvZiB0aGUgdGVzdHMgd2VyZSBsaXZlIG1pZ3JhdGlvbnMgYmV0d2Vl
biBkaWZmZXJlbnQgaG9zdHMNCj4gKEludGVsIDwtPiBJbnRlbCAmIEFNRCA8LT4gQU1EKS4NCj4g
DQo+IEFsbCB0ZXN0cyB1c2VkIHRoZSBzYW1lIGJhc2Ugc2V0dXA6DQo+IA0KPiBLZXJuZWw6IG1h
aW5saW5lIDcuMC4wLXJjNyAod2l0aCBNQkVDL0dNRVQgdjMgcGF0Y2hlcyBhcHBsaWVkKQ0KPiBR
RU1VOiBvdXIgZG93bnN0cmVhbSBRRU1VIGJ1aWxkIGJhc2VkIG9uIDEwLjIuMSwgcGx1cyBKb24n
cyBwYXRjaGVzDQo+IHZpcnRpby13aW46IDAuMS4yNzENCj4gDQo+IFdpbmRvd3MgR3Vlc3Q6DQo+
IEZvciB0aGUgZ3Vlc3Qgc2V0dXAgSSBlbmFibGVkIFZpcnR1YWxpemF0aW9uLUJhc2VkIFNlY3Vy
aXR5IChWQlMpDQo+IGFuZCBIeXBlcnZpc29yLVByb3RlY3RlZCBDb2RlIEludGVncml0eSAoSFZD
SSkuDQo+IA0KPiBJIHNldCB0aGUgZm9sbG93aW5nIGluIHRoZSBHcm91cCBQb2xpY3kgRWRpdG9y
IChEZXZpY2VHdWFyZCk6DQo+ICogU2VsZWN0IFBsYXRmb3JtIFNlY3VyaXR5IExldmVsOiBTZWN1
cmUgQm9vdA0KPiAqIFZpcnR1YWxpemF0aW9uIEJhc2VkIFByb3RlY3Rpb24gb2YgQ29kZSBJbnRl
Z3JpdHk6IEVuYWJsZWQgd2l0aG91dA0KPiAgIGxvY2sNCj4gKiBSZXF1aXJlIFVFRkkgTWVtb3J5
IEF0dHJpYnV0ZXMgVGFibGU6IENoZWNrZWQNCj4gDQo+IEhvc3RzOg0KPiBJbnRlbCBOb2RlczoN
Cj4gICAgQ1BVOiBJbnRlbChSKSBYZW9uKFIpIEdvbGQgNjQyNlkNCj4gDQo+IEFNRCBOb2RlczoN
Cj4gICAgQ1BVOiBBTUQgRVBZQyA3MzAyUA0KPiANCj4gDQo+IEkgdGVzdGVkIHRoZSBmb2xsb3dp
bmc6DQo+IA0KPiAxLiBJbnRlbCB3aXRob3V0IEh5cGVyLVYgRW5saWdodGVubWVudHM6DQo+IA0K
PiBRRU1VIENQVSBvcHRpb25zOiAtY3B1ICdob3N0LCtrdm1fcHZfZW9pLCtrdm1fcHZfdW5oYWx0
LGxldmVsPTMwJw0KPiBBdmFpbGFibGVTZWN1cml0eVByb3BlcnRpZXMgWzBdOiAgMSwyLDQsNSw3
DQo+IA0KPiBTZWN1cml0eSBQcm9wZXJ0eSA3IGluZGljYXRlcyBNQkVDL0dNRVQgc3VwcG9ydC4g
WzBdDQo+IA0KPiBJIG1pZ3JhdGVkIHRoZSB2aXJ0dWFsIGd1ZXN0IGJldHdlZW4gdGhlIHR3byBJ
bnRlbCBob3N0cyB3aGlsc3QNCj4gcnVubmluZyBDaW5lYmVuY2ggUjMyLjIwMC4gTm8gaXNzdWVz
IHdlcmUgZm91bmQsIGJ1dCB0aGUgVk0gZG9lcyBub3QNCj4gcGVyZm9ybSB3ZWxsIHdpdGhvdXQg
SHlwZXItViBFbmxpZ2h0ZW5tZW50cy4NCj4gDQo+IDIuIEludGVsIHdpdGggSHlwZXItViBFbmxp
Z2h0ZW5tZW50czoNCj4gDQo+IFFFTVUgQ1BVIG9wdGlvbnM6IC1jcHUgJ2hvc3QsK2h2LWV2bWNz
LCtodi1pcGksK2h2LXJlbGF4ZWQsDQo+ICAgK2h2LXJ1bnRpbWUsaHYtc3BpbmxvY2tzPTB4MWZm
ZiwraHYtc3RpbWVyLCtodi1zeW5pYywraHYtdGltZSwNCj4gK2h2LXRsYmZsdXNoLCtodi10bGJm
bHVzaC1leHQsK2h2LXZhcGljLCtodi12cGluZGV4LCtodi14bW0taW5wdXQsDQo+ICAgK2t2bV9w
dl9lb2ksK2t2bV9wdl91bmhhbHQsbGV2ZWw9MzAsK3ZteC1tYmVjJw0KPiANCj4gQXZhaWxhYmxl
U2VjdXJpdHlQcm9wZXJ0aWVzIFswXTogMSwyLDQsNSw3DQo+IA0KPiBJIGFnYWluIG1pZ3JhdGVk
IHRoZSB2aXJ0dWFsIG1hY2hpbmUgYmV0d2VlbiB0aGUgdHdvIEludGVsIGhvc3RzDQo+IHdoaWxz
dCBydW5uaW5nIENpbmViZW5jaCBSMzIuMjAwLiBObyBpc3N1ZXMgd2VyZSBmb3VuZCwgYnV0IHRo
ZSBWTQ0KPiBwZXJmb3JtcyBzaWduaWZpY2FudGx5IGJldHRlciB3aXRoIEh5cGVyLVYgRW5saWdo
dGVubWVudHMgc2V0Lg0KPiANCj4gMy4gQU1EIHdpdGhvdXQgSHlwZXItViBFbmxpZ2h0ZW5tZW50
czoNCj4gDQo+IFFFTVUgQ1BVIG9wdGlvbnM6IC1jcHUgJ2hvc3QsK2t2bV9wdl9lb2ksK2t2bV9w
dl91bmhhbHQsbGV2ZWw9MzAnDQo+IA0KPiBBdmFpbGFibGVTZWN1cml0eVByb3BlcnRpZXMgWzBd
OiAxLDIsNCw1LDcNCj4gDQo+IEkgbWlncmF0ZWQgdGhlIHZpcnR1YWwgbWFjaGluZSBiZXR3ZWVu
IHRoZSB0d28gQU1EIGhvc3RzIHdoaWxzdA0KPiBydW5uaW5nIENpbmViZW5jaCBSMzIuMjAwLiBO
byBpc3N1ZXMgd2VyZSBmb3VuZC4NCj4gDQo+IDQuIEFNRCB3aXRoIEh5cGVyLVYgRW5saWdodGVu
bWVudHM6DQo+IA0KPiBRRU1VIENQVSBvcHRpb25zOiAtY3B1ICdob3N0LCtnbWV0LCtodi1lbXNy
LWJpdG1hcCwraHYtaXBpLA0KPiAraHYtcmVsYXhlZCwraHYtcnVudGltZSxodi1zcGlubG9ja3M9
MHgxZmZmLCtodi1zdGltZXIsK2h2LXN5bmljLA0KPiAgICtodi10aW1lLCtodi10bGJmbHVzaCwr
aHYtdGxiZmx1c2gtZXh0LCtodi12YXBpYywraHYtdnBpbmRleCwNCj4gICAraHYteG1tLWlucHV0
LCtrdm1fcHZfZW9pLCtrdm1fcHZfdW5oYWx0LGxldmVsPTMwJw0KPiANCj4gQXZhaWxhYmxlU2Vj
dXJpdHlQcm9wZXJ0aWVzIFswXTogMSwyLDQsNSw3DQo+IA0KPiBJIGFnYWluIG1pZ3JhdGVkIHRo
ZSB2aXJ0dWFsIG1hY2hpbmUgYmV0d2VlbiB0aGUgdHdvIEFNRCBob3N0cyB3aGlsc3QNCj4gcnVu
bmluZyBDaW5lYmVuY2ggUjMyLjIwMC4gSSBoYXZlIG5vdCBmb3VuZCBhbnkgaXNzdWVzLg0KPiAN
Cj4gVGVzdGVkLWJ5OiBEYXZpZCBSaWxleSA8ZC5yaWxleUBwcm94bW94LmNvbT4NCg0KR3JlYXQh
IFRoYW5rcyBmb3IgdGVzdGluZyB0aGVzZSB2YXJpb3VzIHBlcm11dGF0aW9ucyBvdXQsIHRoYXTi
gJlzDQphIHZlcnkgaGVscGZ1bCBkYXRhcG9pbnQuIA0KDQpGb3IgcG9zdGVyaXR5LCB3ZeKAmXZl
IGFsc28gZG9uZSBhIHNpbWlsYXIgcm91bmQgb2YgdGVzdGluZyBvbiBib3RoDQpBTUQvSW50ZWwg
YW5kIGtub2NrIG9uIHdvb2QsIHRoaW5ncyBhcmUgaG9sZGluZyB1cCBuaWNlbHksIHdpdGgNCm5v
IHRyb3VibGUgcmVwb3J0cyBmcm9tIFFBIGFzIG9mIHlldCAobW9yZSBrbm9ja2luZyBvbiB3b29k
KS4NCg0K
