Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1CA31E844;
	Thu, 12 Mar 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323486; cv=fail; b=Z0iG9TN3YJhsIXmbf0aK9wjLVBcRTGzamD5C/GtuGvnel2ZEL+KqJ4RmZzV69/tX2rdXxbXSa/tj4ej/msQXjvpQCuV2u/NWVFnLn/9gPtMt71nT5v8RkV8df5QnCGb0J8hjCLmAW6KCbgzTH0X7r9PYs3cZmCoYM0jNy3yHr/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323486; c=relaxed/simple;
	bh=nRm8/vi3DPvqJsSY4/TzaQO75UDaUZw6is0fQjTzAWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A5G1RFtEIzGymv2EiPKgy+8et7RIfTxlt9FSby9uhJ6cjcEF/Y4Kt3i5m6+s5JOlKSdt95gAKdhN4eCRCvwqcirbRp2Bq6JxryKUGnpejX1BJUoYIWVwA3qenDzwb2/0WiFEwfojxuHcqAIAAGvCs6uW4vnnKCseKGo2wTmFyzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hqTRYw+3; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hqTRYw+3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buVxgFRIeGcsOqUJ21+jx8P+fLLK2uaFY0tTyZQh1+nQT8DL32ikobNzzU37fYZEEjfYyhDiJJZI5o8Kp/Us+5L7b/EHArS1XvNQk5Ww8o5vK7WysXHqJg7taEUFJlGMnTvqJByI+LbCiK/yv/IvtmDG0mkxMKNUG9WZ7KkoaN6BYaNe5zTTj8TY2QCv05rt0mOZu7WD/8nRkYyqFMJ2Qd1xSOBjHDIY+jIJGYapGtcmwoE1lRYW8FtxKtGPh/pD0M+crc6TCwjso1lQz9VpPWh59/DySQc9V/MqITFPzHOeEYHufNMLMXzpIgLDNjiUxegf8MLLE2hPTuadxPZ/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRm8/vi3DPvqJsSY4/TzaQO75UDaUZw6is0fQjTzAWk=;
 b=ru1IwAGO9VsR33DUXcWLejXgTzTnDUC/QN1AkNwYqsjvk2ZfZu3MLl3qsLZYdsZUvFRkJWs6UaeNgwURmocVBDr7XERD2/DjP96/FMitZndj7hfSVXoI8Wu7g35+IIvsI/Ni0R04146Y6RpAkQnUqbTTHBE/pxlI+aCAnt9bQhRXUUwkUzJ5k7oVeHkbaDN1djoCRMfsAEF6Ot7fHhSa4eL8Eamrw3YOATJ8/6CnoJfljLOOykrMw0joHWwGB3vfOYl0+5pRcyNjf8QbYh50NmJLCNreFy9DVRs83Dw/l4KLrlvkz94RgqAIfvdwbBe3gNCM6mloccy8yqMpI6xQPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRm8/vi3DPvqJsSY4/TzaQO75UDaUZw6is0fQjTzAWk=;
 b=hqTRYw+3cIZFRfWDQXdMnWuKmLCWWO6RAFlFjTEizpGhXvpqqdr47kb+MsmJ/54hDdS2Mwr+b/KHzucmN2aIYVPVuEvL0U5TYVS4ceppNEtXHk8ud/XSgfsHowbKJnqbWOI3RNiMFnqF8NO2AQnwjIetL1RxLQNPRcE6Fli1OxBYgCUAbOdueAJejxeHdG/y7pLyRrHxEwql9/tf5yChwlXz7JThcuZjmD2hPJs9a0IcNrHNarW4lm/iFNNmEdwuKR41kaWPwIqfvLdP/oYMDjTFSyoUTkg3gptCrTVTKwmZ/lDhAJ4K0ORQ/oeD+d3Sa007b3uT6lxRWSzcwl9gDA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 13:51:22 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9700.003; Thu, 12 Mar 2026
 13:51:20 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, Neo Jia <cjia@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 00/15] Add virtualization support for EGM
Thread-Topic: [PATCH RFC v2 00/15] Add virtualization support for EGM
Thread-Index: AQHcpNzaOt1igUkxvECzSrGf7z/GFbWgQqmAgAivw4OAAPGAAIABF5E+
Date: Thu, 12 Mar 2026 13:51:20 +0000
Message-ID:
 <SA1PR12MB7199673D9DE79C11DB6B9E33B044A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260223155514.152435-1-ankita@nvidia.com>
	<20260305103335.74fb8141@shazbot.org>
	<SA1PR12MB719904F9ED153FF4BA4EFA28B047A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260311143706.2095a547@shazbot.org>
In-Reply-To: <20260311143706.2095a547@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|PH8PR12MB7304:EE_
x-ms-office365-filtering-correlation-id: 5c1527f0-ba2a-46ac-f15a-08de803e70da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 EXtQqgPZFNa7gYfvUd512lNeHoilAJPAQnW1pHUm+dbgekJys+cp4W9URlhxih3PBHVnWdB6Zf0ff7T0+zbypOsdtHgIlYmt54FWxzwVcgZkAQ2W1n5teHF2ePbYDtx91v9v0ExIb0Hd2dN1z/WrV1cq0NkVIPQnF4sJCXea3nbOBspWeUTalORJgaoku7IZIB0n13FMNSXFG2YbE3ZvYOe8UKnvliplUvId5ZkETZjpKVyV8HNxarNjpTUZSQTTvZ15bN3HPG1XcfwKwIFf9uOTx8txd8PvFlnkV3n6xmZDNKdW/ip5sUS6OBk0TK03npZA3wYmH+SOn08mSQmprgY985+TR+jx1+EZOs/l1tLSgrbzVSdTNU/uCu4RbqBgNGuHFtijxau6ofNS4Ypd4s4pqQ33/rfB1PLBGraD50GZC1I4B3uSslriF8froLRB3DTbrzTM5cQrSzT38EJT/TlVRFDGXQCLRA2DMulafPqNArATggsHEw6YrwBLl74UROe7/QvnnJ3iahz/pR88sSB07NIfGosVHQqVezR8BjUBKPGTJMwcNt/RtAuT/5Qc0npvFCQIwjh8bMIMtvIRPRwHIJq9q1YkGserjijghFMUjjGueSVvywmXwiBYObRmOpsKMST9NJFWqQJ67sowkJP7YSOhust/tTzFVs85+E57kT+ac2YBYMJF0PXI3wYfjPrrlNOIguTY2mumjlmXZSOxP2VGuJFpdKLwh4ngQm+To34Jntkhdxn4xOpALdP1aHz+bKFm2wqK6VUkgQcW81r0g63gj/mRSPhWYISsHlM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KjgKN7AntyrlT5yQS3eVr/gamMwhIN2+MPqHPvkj/JIBMZXQsFcc3vaBaX?=
 =?iso-8859-1?Q?ruoEXh7fnwJUKZrJWB6JIPYaZ3JlP6iNLN1LwpijIF6cna7M5uByU+ySen?=
 =?iso-8859-1?Q?C4tMh5xLYnmjLBaXbQ1KvxYyf2ffusOIIh3dkhYOqJWedjnOpGKuAw+W+j?=
 =?iso-8859-1?Q?gf50LqO4Drk/yoi0UVDTYuihnn5Lm0Y0TFmoYJjPboYLoBZXVaPDIYOhih?=
 =?iso-8859-1?Q?lhWMYk73RUR0Ujdp1L+WHcWPyuGMA06LI4s/syabP6bcWkTGV+0duX7ePO?=
 =?iso-8859-1?Q?jlMJBSt4TZF5zP+m5eVnLx+G26NPWfUfBXTTiE3NrdMQWV8f+vNmSV9ri+?=
 =?iso-8859-1?Q?nj75dx7VJJ+Uvac+SslADGrPcokqcv040tSR7seXi1EX9/aBnPhWWNWoP9?=
 =?iso-8859-1?Q?IuA14XTlRInt6WMZK+8p2naAUaK3Dofk8up2NWGLhAmIbiXMtIAWkRbj88?=
 =?iso-8859-1?Q?j05r7lJLVF1oNH6VTN4GJxg/lBs8U09FYWROmdveYZaY4TmmWpgCq5bIy3?=
 =?iso-8859-1?Q?R0NkLq9oloyY8ZD/3W7/6UbYFe7Btafu9jvaEb5g/yDLQn3UrtT2LFW4yU?=
 =?iso-8859-1?Q?UADm9z6y8KPgV3fCG6ApUfpviJItU3LLZQsttNTjvBrCeDVPkZXU4FJ4c1?=
 =?iso-8859-1?Q?w6SJ5YZLbtqN0pLFHQINMuJW34eQUTZbLz86QrPlMYhiW/xE+KeXDc/G/o?=
 =?iso-8859-1?Q?pf8+yhXz/UwnALWm9SPnC9yk0hf4si+aNZwRYOp7AZBrUZAl969jWqI8fS?=
 =?iso-8859-1?Q?OLNaY4hpxEWEK5xFnfttaFKk+QSUvraTE/R5oi8OSE0V6nN0kBPLmrE29w?=
 =?iso-8859-1?Q?H18eqf4KdaSng1TCxLLbM3u6jA/COwyjsOYJXw+gJZ9oCCe9B333/JQm9S?=
 =?iso-8859-1?Q?0TewqNAL5ihhWzJd6EmGBSFMSdLgQ1F31V6lFeCn8X2LCRebVgUyfdxkQ6?=
 =?iso-8859-1?Q?orR/Ae6W4wdQ6ocvWYklfd2nkbFXKYSzkXCDaktPUqMeJJvzDjK67rvCnM?=
 =?iso-8859-1?Q?hkN3F8TbyBBvigzoFhbkgHH/H3bkFLjk0GNOnkjg2+Ji2fg6IV3u6jMyLq?=
 =?iso-8859-1?Q?QWVLPvc5qdpokIEaFpEJUwlsghK8n2cLAVJDAX8YCCO7CsyDzJQHXAGltS?=
 =?iso-8859-1?Q?pQzaLspnrDp0YKaI/zLZ2lwE5vlCKu0tw7EGew6oUfb8Bj8aArMD1K2smb?=
 =?iso-8859-1?Q?eLRAfCIwojPOY36xa9a9wywqhXLyqXVTNSsrq9bJywFDKmr0Eu+VPKrazO?=
 =?iso-8859-1?Q?dYAGRzfyFyBrAjvXgeiI0P4KmpGVb5v8oq24agI3jQ9/SkfKRAfZF2Wzbu?=
 =?iso-8859-1?Q?wWQjWt2DUFAUJYCqFzNDRQ4/LGZGtXyTjaXsUmVelVnaMfcolhLZXelfAh?=
 =?iso-8859-1?Q?Ue8YUf4hpL9S587PXzB5rRt1YmdRfd0MV7RKW1y9ggESQcfcttLhDCB5KE?=
 =?iso-8859-1?Q?ZP7M1gCQEz6udVEssKEZA9YDr0JY8wjjJh3l8kdLmxVOatDAQcX0LqGfsu?=
 =?iso-8859-1?Q?TrkgsB7CdkQNayjTYLLmnZ5bBbTcfFgOpDh5jO6jMHG25ZLg5bnCpqpzTd?=
 =?iso-8859-1?Q?0SuJ+fYhs/S/o8rea3X1UIzDIUxJGDxYrvd+PB8/V3PJvym3YKQSIJLeAG?=
 =?iso-8859-1?Q?sfWDXeeks7ambVZQYGKOMjEJvr3i7GnjrNmim72qHX0OjYmvmIYk2NG1wj?=
 =?iso-8859-1?Q?tFR93vlyP9Q58Ak2g4aCrbhylWEXfmczqtZPnL8f8Fyrh8WHzH4obtuK41?=
 =?iso-8859-1?Q?Vab504vOiAUaEku576P/Tc9KToexKBpz47BQYvVQWnEeem?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1527f0-ba2a-46ac-f15a-08de803e70da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 13:51:20.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVXzm5Ddtw90Csw5QRZEe3jlunmBS2bGk56hDeQ6BJijPlrpxHjox3joqam8/GXeVBQgfVIKriTO18GQNxw/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304

>> > nvgrace-gpu is manipulating sysfs=0A=
>> > on devices owned by nvgrace-egm, we don't have mechanisms to manage th=
e=0A=
>> > aux device relative to the state of the GPU, we're trying to add a=0A=
>> > driver that can bind to device created by an out-of-tree driver, and=
=0A=
>> > we're inventing new uAPIs on the chardev for things that already exist=
=0A=
>> > for vfio regions.=0A=
>>=0A=
>> Sorry for the confusion. The nvgrace-egm would not bind to the device=0A=
>> created by the out-of-tree driver. We would have a separate out-of-tree=
=0A=
>> equivalent of nvgrace-egm to bind to the device by the out-of-tree vfio=
=0A=
>> driver. Maybe we can consider exposing a register/unregister APIs from=
=0A=
>> nvgrace-egm where a module (in-tree nvgrace / out-of-tree) can register=
=0A=
>> a pdev and nvgrace-egm can use to fetch the region info.=0A=
>=0A=
> Ok, this wasn't clear to me, but does that also mean that if some GPUs=0A=
> are managed by nvgrace-gpu and others by out-of-tree drivers that the=0A=
> in-kernel and out-of-tree equivalent drivers are both installing=0A=
> chardevs as /dev/egmXX?=A0 Playing in the same space is ugly, but what=0A=
> happens when the 2 GPUs per socket are split between drivers and they=0A=
> both try to added the same chardev?=0A=
=0A=
But that would be an unsupported configuration. It is expected that all the=
=0A=
GPUs on the system and the EGM char devices to be attached to the same=0A=
VM for full functionality. So either all the devices (GPU and EGM chardev)=
=0A=
would be bound to nvgrace or to the out-of-tree module. Please refer sec 8.=
1=0A=
https://docs.nvidia.com/multi-node-nvlink-systems/partition-guide-v1-2.pdf=
=0A=
Perhaps I should add this information in the commit message.=0A=
=0A=
> However, I'd then ask the question why we're associating EGM to the GPU=
=0A=
> PCI driver at all.=A0 For instance, why should nvgrace-gpu spawn aux=0A=
> devices to feed into an nvgrace-egm driver, and duplicate that whole=0A=
> thing in an out-of-tree driver, when we could just have one in-kernel=0A=
> platform(?) driver walk ACPI, find these ranges, and expose them as=0A=
> chardev entirely independent of the PCI driver bound to the GPU?=0A=
=0A=
So a new platform driver to walk through the ACPI and look for EGM properti=
es=0A=
and create EGM char devs? =0A=
=0A=
Maybe it is okay, but given that all the 4 EGM properties are under the GPU=
's=0A=
ACPI node and there being no independent ACPI _HID device identity, it soun=
ds=0A=
a bit off to me. Do we have a precedent like that?=0A=
=0A=
But as I mentioned above, the expectation is that the EGM devices and the G=
PU=0A=
devices to be assigned to the same VM. So would it not make sense that we=
=0A=
keep the association between the EGM devices and the GPU devices?=0A=
