Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7752AD2C;
	Wed,  8 Apr 2026 05:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624584; cv=fail; b=C8Um7MDTiSygiYTwM9GVPudelpcYLxgaJ3T4d5Xv8XPnbfT4bQ8XM/MJrVlY9Yzz576k3spGu6HbJvF+3Zy880kN3XHot5WLB6TceTl8D3KIX16iNrglHwM0+95uif0BAARI48gAPm/wMUGFNAx1cpeWTuveeNIU1wvypApyajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624584; c=relaxed/simple;
	bh=lPdNHOp3QcWBaHDGJZncjTEO3Qf1VthOcMLnpvfjBEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hHvfHoDPrEtPLLsSeM1g5AmdTcU+SE3UOpGGFH/5sxi7TRNfHbiK1K9PoaVlwxraYsidGbwKYfVRIMSOxUR56n798FaB/kBQFaukNylWoaRikIFTKSAXMcBW+GxNZT3vvwJ6xqacn+kXsEtbrnEMv0xCg6c2ujLW8MowtnLWNvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iBQ0mCD4; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iBQ0mCD4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbRs5rpZ5WZR2vRDHuL/mOmBk1l+xPzkdCEiwMm6qCWwHk2V5dIjeapResT0W6Hjc+LBKySXJL5bYFzxj+CMoRkDB6rKuV2Erxrp+yFiNN2Ui8tGR7M3Sad6yPkgLSFjDC1TuNrKA4Jcn5yfx8lu3JSmjPM5ujO010PC4ynPPeGQA5Sq114czXm9ZpHzj8UjdEoGf4Son9COmGNijp2XN8rP9BhAw7mRoYZFZBxpjgSyu1nFeEQuVe/1BOA+aJdJ5/x1iAximBkeB0bPW2mHUOf+bDXdvFZxyOm1RvpxQetowuQfU97sDD1RcmBI65x/SsYcafzgxmmqPq3SduWRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LUs1LYhC/ci4qrnJFMnQg2aelN1h5f1/zriEK02+wk=;
 b=ScLT6/sCLtqYbU65UoBphDY52HFeDHHQ/MkRO0lAp1NzZ97GxlcIiXF6JlcwI9guQSOwSvHlQtViNx1lmp5Bcjj/o1BJpXpu6PRE9dCyHp2Dxsns43n99x6RnJlj94ps+MRPMt2q+k9CSCLbYn3di6PrVAX37WRTafQam4tUHYLCem6NYzDdM8ssZXnRC6FG3QY7IXEXwmqgU8be7ey0DG8wnaFHMrhdDrkJix5Y1de0D3Kru1kekDZcKiVgxnR+ZCVBGWHv0Vao1jXecXsiSBwQG5qjG4P+8xVNprOZVQXOVr/Ue09JtdoQ13sE14FXXU4Gki6tAOO+zbINGRPYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LUs1LYhC/ci4qrnJFMnQg2aelN1h5f1/zriEK02+wk=;
 b=iBQ0mCD4PUYZmLdYtklCwLKb5AwOItEBV3Fucuk7wpoXe3sMinkfrd6Z/eMo4S8RCPQT0+/7OzE/1yBkh9MuCzW9RN5fvfCeJDoEfdqbZJ+GHKJ3ymHm9QP3XU5Ggo9tMxmmLPp2P6AdGtrnITSW6Lk2Lanm2MgsKNaqo+rpkcJqDVcJ/Z6C2CcK5hhOFnQSKtKxKMhMkraAlgAcsAQLQ7Ql55GvN7MjLDAiuJNhEPfIZ76FN6ZKGF33IG5TKHpihu/StQUW+CD+x/V5DhGaHHRdEy3ccVKb9eVdUgmoHWswSstnL9IR7E7KXfqrR0uzFBApGbEgtVRkc7nDUfLTHg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 05:02:57 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 05:02:57 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v1 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHcwAgGhYk601IYBkCxAeoJvEEZfbXMYEmAgAhG0Tk=
Date: Wed, 8 Apr 2026 05:02:57 +0000
Message-ID:
 <SA1PR12MB719981EA50D45CD0A7B81A9AB05BA@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260330054220.620049-1-ankita@nvidia.com>
 <20260402162931.23df3c5a@shazbot.org>
In-Reply-To: <20260402162931.23df3c5a@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DS7PR12MB6310:EE_
x-ms-office365-filtering-correlation-id: 12db9f15-2aaa-4ea2-0566-08de952c19a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 aiR1ppgtq/N7D6t9MteS3iE7xyivJx9OPKaLGw5FAiMtr15eO3syFVN1ZotO2JO3IsBdJjA/jxVcjVK8bdozKEfcjfjgFD71u0x4MCBYrWUOaVGY/UXS+Lk6b2PtbcHh/5zsJWbTrr5nNx4jE5muOYMGz+rnIYPuBX4jMaGubvH9uYbprNo3/huA+8RSIpb6+xjK6nOuQWGOBWPa0MxGl/gAc3MXnsWFDrnVRLBVLq6NuqL/xz4+tUUAdEFkN5Irv8gtzsshKsCdccdo0c6w+skGh0qDYQ1T7Wj04QPHELUAyRdVLWNCkJ3hk4fbywJO1SFlYiPQrXtnpYT8v3PkPx5VLMUMXgvsGuKKsRkE1qrGTVrfBPcShxyNBpahwzvYs/CxYnra1eLz9Dlg9ArMZrWFyz6S3qmrSkiMc0BS5Zq340ppPSJSUt1ceMZdmhNKwJVzfK9tB7knW7tOhTgExAvn+gf7B84+3OPSf/xHJPA5SUeOdbUVCitPaIpuKx0qam1qkJiPC/o/fYg02zuK57ih2rwni92Tkii4wl5j1vrvOlteyPt8dwc2MmXdiRkrMI0HZ9I7eL+B55q80RHtdNIosoV7qcmkK1wPaU9ZGXrYRB31yU8Q40bJLAwA1HoX79GNCpKyAIMBJQyAtz7QsauThb2V6cS7tkqvJFXpYID15bPkb6pUpWnW2bbuSN+t1Xp74pLht2+gIrFyKe+g5np6jh7Tv9rVUmJIN0RIWnrbF2unXtZp72q1cmdXXQxMAzIm82x3wv+2cNdoGiv7yH9hgLP9RTzn7WuSRhOWb6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?avSwBoFVLYwcukyMYmtm1NCK1iVlT6kyqjjEGcQHa+is3NgdwEICjBqVBM?=
 =?iso-8859-1?Q?lrtPwFqZlZbnnqqVuFjchTQhf9PmuVFE8laEqYlnM4ZLULR8+T74Di5NjN?=
 =?iso-8859-1?Q?etIxwcGpumeLMqhIoiezXf8Jp+LI7cosNIPRCkoWXaqwKDpi/40WGTtJWb?=
 =?iso-8859-1?Q?4BINoO6ss/YOC6WH2h6JNH8cqxCjoCy8HvPlhoevi6ppoDsZj7Dom+IbBy?=
 =?iso-8859-1?Q?bkUIvysU2+uWn2LKS/14oNCf/1azNk0byuyT89/UEpuV5Hx7CbrXXE0PnK?=
 =?iso-8859-1?Q?8PYp4v9+toQVLsjObCL8kIZ9N0a8vanhtWnIi5wG/RuhKDBMUU2QPqIpGK?=
 =?iso-8859-1?Q?dd49A/2zUNPbsWMx/xadBB3bGLvX2ttQHXS9zGzUbdaUdy3OUPuaPb5uxm?=
 =?iso-8859-1?Q?8z3ASzgqq5FtEs81+SPfY5W4FnJXHnUGgtty+dIO9Rmhcv+K+UDEcZM+ie?=
 =?iso-8859-1?Q?TUhgfhfav/QSI2KuuFmKfTBrAnHUM0bH6DX7rBYWhUI3niA23StcnbvL6/?=
 =?iso-8859-1?Q?it0VE+DbkUUzbndqsRyiuD7G0CmWFlyBUNIlwdQ/aa8rk8UwnYj6hRLNxi?=
 =?iso-8859-1?Q?J8S1sonUg3gf82wU3sWrxWBRAqAmFeQs8zYN6vWxsySl4Ip/+Y3vF6+1nX?=
 =?iso-8859-1?Q?F8RLtWzYQYmNyNOgdg0/u46uHDpRL1bDwtHkez3oxt7lStz/k5f+rGalvZ?=
 =?iso-8859-1?Q?u8LHMFxhxr3Az71goKGN8RKkBFu6DiSRP95PTuTLoDeg6gJciXPeLfIwP/?=
 =?iso-8859-1?Q?qObQWjkJfAj6mPVHi6KGNBoUN8Lcxg6SK5Mz1Xc6f4GY1b4/QCwUJivp7Z?=
 =?iso-8859-1?Q?s4rqLh3TT9EoUgZFdHKEd5NFlijd0hPDwJk0FnmUWBmsV7LnxrTxk2daSr?=
 =?iso-8859-1?Q?rJ0uSMddJe+6hTVdau3gJPyiit1o4PjwxDkh/HHqGyl1RS3FnPdIKUHqd7?=
 =?iso-8859-1?Q?uCD/djb29vP0L9Uf35+RO1F2isv1LNC7xe3XrczmrPPD2xElCYlZWSOCJt?=
 =?iso-8859-1?Q?YBxI9mc1RnbT3/clkKDCUw+kEbU5FmxQSZrU9H9Ymb1L9+A9DMuT0/L3Pd?=
 =?iso-8859-1?Q?OCkJMwpmq4hITKNBQgCeZLQjDS524t7ISPONjDpJ9nNT+cobEVW/hp6X88?=
 =?iso-8859-1?Q?0XfZaOZ3AJT6/z6w9AL8UUQzbxhT6tp2gavBPUy1+SmPaEdLHUiSyo1fof?=
 =?iso-8859-1?Q?KbZuk0Wrxw/LREBNTYOw5nrAsoJLSTdTzF4gfKCnnXJWt1neYUkxJ4Dl+m?=
 =?iso-8859-1?Q?+D0x1VClTbjhH6zvkYhwmloNrqXqcjEDP7RoGyZCN3aaWNlHl0+/qNFFRH?=
 =?iso-8859-1?Q?ISmn2Xfkm+U9F/D/OKokIKYdZv/BXpTU+/rUYAVNqM6tDdMgxVHIkf5sfw?=
 =?iso-8859-1?Q?DoKccKBYp8Qr7qUFFfyTkbSUHy14ux36pYK+Wgh0d3mX2EoGSvgBtJThaZ?=
 =?iso-8859-1?Q?RU5hN9nmQv+mjFVU+POuase+duu7pFZKb1cFxe+lIp4MiUPKwLJ/cyHLqe?=
 =?iso-8859-1?Q?oX5NaDqGvGhPNVffq1cJgIOty0N9ZsywFl60E3ty2uHHNdYZMPxmuYygc0?=
 =?iso-8859-1?Q?hUBvhF+0o8/VsirKrNVeJuG7Nq57qZY+KmXpYEcOs7+BbZwTq/YrsFK9Ga?=
 =?iso-8859-1?Q?HWssl5hosoddCEjKxmxDPtCWjc32+ddONiosnPl5mTSBbcvcy0Vdx8Iexe?=
 =?iso-8859-1?Q?tLFYzIYH8kE5Ih8D/TDUHuNkD+1QrabzZl33lmGuAzULnWlL/AINqj3MSF?=
 =?iso-8859-1?Q?mfnDWpAmR672MOs6kBWf38b1tPER2tJlfBafIDRs6UFcht?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12db9f15-2aaa-4ea2-0566-08de952c19a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 05:02:57.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31UjAri+G4WbtrNr7VYX9iHGeP0Af+RUG+Ed96i68/mamfb+cY12WB3ii5B7V8bMEJjwTWbMTl1hi1WZ7HDusQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

Thanks for the suggestion Alex, comments inline.=0A=
=0A=
>>=A0 =0A=
>> +#define CXL_DEVICE_DVSEC_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=0A=
>> +#define CXL_DVSEC_RANGE_1_LOW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0x1C=0A=
>> +#define CXL_DVSEC_MEMORY_VALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 BIT(0)=0A=
>> +#define CXL_DVSEC_MEMORY_ACTIVE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
BIT(1)=0A=
>=0A=
> Looks like pci_regs.h has all these:=0A=
>=0A=
> #define PCI_DVSEC_CXL_DEVICE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=0A=
> #define=A0 PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 (0x1C + (i * 0x10))=0A=
> #define=A0=A0 PCI_DVSEC_CXL_MEM_INFO_VALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 _BITUL(0)=0A=
> #define=A0=A0 PCI_DVSEC_CXL_MEM_ACTIVE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _BITUL(1)=0A=
>=0A=
> We should search and replace to use the common macros and drop our=0A=
> local versions.=0A=
=0A=
Ack, will fix that. Also add the missing MEMORY_ACTIVE_TIMEOUT=A0in the=0A=
pci_regs.h from Table 8-13. DVSEC CXL Range 1 Size Low (Offset 1Ch)=0A=
This will replace CXL_DVSEC_MEMORY_ACTIVE_TIMEOUT=A0in the patch.=0A=
=0A=
>>=A0 =0A=
>> +/*=0A=
>> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 =
Low=0A=
>=0A=
> Is this range 1 or range 0 bits?=A0 The pci_regs.h macro suggests 0.=0A=
> Same for the commit log.=0A=
=0A=
This has been a cause of confusion for me. The CXL spec 4.0 has the followi=
ng=0A=
8.1.3.8.2 DVSEC CXL Range 1 Size Low (Offset 1Ch). So that's why I used ran=
ge 1.=0A=
=0A=
The pci_regs.h does not have any clarification. It does point to the same s=
ection.=0A=
/* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */=0A=
#define PCI_DVSEC_CXL_DEVICE                            0=0A=
#define  PCI_DVSEC_CXL_CAP                              0xA=0A=
#define   PCI_DVSEC_CXL_MEM_CAPABLE                     _BITUL(2)=0A=
#define   PCI_DVSEC_CXL_HDM_COUNT                       __GENMASK(5, 4)=0A=
#define  PCI_DVSEC_CXL_CTRL                             0xC=0A=
#define   PCI_DVSEC_CXL_MEM_ENABLE                      _BITUL(2)=0A=
#define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)               (0x18 + (i * 0x10))=
=0A=
#define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)                (0x1C + (i * 0x10))=
=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (!__vfio_pci_memory_enabled(vdev))=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO;=0A=
>>=A0 =0A=
>> -=A0=A0=A0=A0 ret =3D nvgrace_gpu_wait_device_ready(vdev->barmap[0]);=0A=
>> +=A0=A0=A0=A0 ret =3D nvdev->wait_device_ready(nvdev, vdev->barmap[0]);=
=0A=
>=0A=
> A bit of a nit, but it's a little redundant to have both cxl_dvsec and=0A=
> .wait_device_ready on the object.=A0 It also presents the problem that=0A=
> each variant has the same prototype, but requires a different=0A=
> parameter.=A0 Wouldn't a wrapper be a bit cleaner instead?=0A=
>=0A=
> static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_co=
re_device *nvdev,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 void =
__iomem *io)=0A=
> {=0A=
> =A0=A0=A0=A0=A0=A0=A0 return nvdev->cxl_dvsec ?=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvgrace_gpu_wait_device_rea=
dy_bw_next(nvdev) :=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nvgrace_gpu_wait_device_rea=
dy_legacy(io);=0A=
> }=0A=
=0A=
Sounds better, will make the change.=0A=
=0A=
>=0A=
> Thanks,=0A=
> Alex=0A=
