Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304B38424C
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756653; cv=fail; b=E00lK+egzPV8vdTJI814Yme7uwzP2YVXAeDgnKgSdUeyQPyRiU4I35b4psBYjhVtqkzriPAt3clg/whs+f2Z8n/cm4A2BZ03IkrD4fLqmLSibbVk8OIRs1p5fFYNHhlqhR1et54vE/o1VlJ9s1YFygVQe95/LBtu5bwy/QyE/L0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756653; c=relaxed/simple;
	bh=VTPPZrEoCF8tOOIU/zF2nRLujkkYCOZaVbr0MykLAYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HMS7GJ0menj7WrMnjumvJOvRjvFLnQaHWbQ/bAKU2bu2Zjsa9JrwRYDemUbwBi+Me0mWQd+97jMF7LW5aVv1LDtNba0caVReKWzr93be6nu64DvzeuiJ0m+tbAzaJaQaKNgS90S8eXDWuAEWLnFPbgSsXt5ZOs550WYQdc/gAiU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sx6EUha0; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Sx6EUha0; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sx6EUha0";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Sx6EUha0"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ayiL2xlivs+AlA0MyaK0IJTj6t/DWDrS5o0MO1RpJQiO/BLY/YFMcS+11lu0SeTT+0MKiAI8D/+kQm7rrjbXKHTPil1d6HL4OxDmKJ2iglGH+pYdPju1ViT9qGhDvzZ3GppfM2M8BQWNSVBXv5DyvvLheRoOPscx/SrfiTrq1t1501l+IwMniptH/7Vj41zhfwo7lv1vDJwhcbxU5BAUooljH4Yf5O9Nzls0MV1TcnD9Jvcq4G0v8Zn8Gd1yKVVFCZqThUVPf2S7IXgwppCM4aCn4pVs+TFdJ4xQxzL+/ZrRunw4G772cqsvur553EBRqvn9bzceyuoWMamEUeCXUw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTPPZrEoCF8tOOIU/zF2nRLujkkYCOZaVbr0MykLAYo=;
 b=hjKlidLximFgJp+x5uHg+1phMy5O2lt8IQp61iBBgUw39/bBYUFgaGcTBn6Ct5/YYIPqWssbDCV/d3qyw5afBlKIbZMjVcFU4cA24w8yUrJ6Ypb1J4PYYoSgMnGgkYIJftlrxX/kzHHGqNAm0jfouI4h+HnIBuJ8HgBKfAryFRBjycTFGYx7rtP2WIOYUQPxOWqVWjbbiYYhkvD0b+g4bIVWqGgQtn1F+r7lLNtHAVMHww+pi6w4B4uvDrVzXZmTD1rRiOlB0QEssaeMBv8v9f4l1+L5TSl4RNbC0zMtSx/yASqPXQmPNVPp4b2I3SwgQJLtyuTaEy0sn5O9Hbx2jw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTPPZrEoCF8tOOIU/zF2nRLujkkYCOZaVbr0MykLAYo=;
 b=Sx6EUha02YyUeFonrkOj4RPQ47HoESFMHCqnYrStsTPykNFhU6QJOJbjJvoHy7sI+PVx5I0sH3A5KvydeUT13FSsAgaG/H94W46hAImT9so3FS0xcn7h5zhhQIOrfI20jmFrCEYBv2nmh+YVRCyVf82/qjwGkGl69O4BCRNDJD4=
Received: from GVX0EPF0005F6BD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::647) by PAXPR08MB7419.eurprd08.prod.outlook.com
 (2603:10a6:102:2ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 18:37:15 +0000
Received: from WA1PEPF00009B3C.eurprd05.prod.outlook.com (2603:10a6:1d8::11a)
 by GVX0EPF0005F6BD.outlook.office365.com (2603:10a6:158:401::647) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.15 via Frontend Transport; Fri, 18 Sep 2026 18:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF00009B3C.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 18:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOyxMVqWRRqzd0aQtm3PSRbhpdsffrE1Icb+xOzOay1e2mfIpbl4AxgJeHQ9Fvb6A06bc9rkOWz5R0oDeabfhdz09D8+JP9+tpbaYp/06EOEaKG2filnoTPJzTAlV2Fwbu/dZ1fmhcOKRXOVe6KKdVh8Seb3RxGRbDeqbxc422abA2/fwiRQWIlPMMEJuNkwJcayCj8Qi0bxogctdNqnbrstVHKUN/dzW9qWSA8t7S6pgwlxrh1VzOHi8dpRUqOPPxfkY5hTuCmL/2L8zqVZ4xUC1bJb3nmbiMla5vonGU1nreAJ1/oCcrYEpFhOgSkyHLWRk1sq+d9eevWR0DntUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTPPZrEoCF8tOOIU/zF2nRLujkkYCOZaVbr0MykLAYo=;
 b=XWyw/8yadqKcT/P+e9CqXhBJqot1jWEpghn+rx/1T00tO4inlF0HOlYBlAmx0BGZD/xE9Gr0OJVoDFeZjuWH+PMK3vznC65wW8tRLQQESr4L95UU7iiE2eCD+VFvOQVdpJHxsWQF4vgr/TcTaOTqqlNKApOqfzPIJCcBe/7BO8Fd33qDeXAd3kFspuAxhAjzfjidjx+Km0UJ9c9nHfwhyi9XEsCjLAkfA7aeh2K9U1hc3b6lPGW8oErE3/deMXVwgKpOL8HMbDFneqGVC2RBMtNuTOSk2/Vi79lPMY7HY2mCvJR1dPeeVNyH4777YWg1qGMfgxfogQbiI78iwe9Dfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTPPZrEoCF8tOOIU/zF2nRLujkkYCOZaVbr0MykLAYo=;
 b=Sx6EUha02YyUeFonrkOj4RPQ47HoESFMHCqnYrStsTPykNFhU6QJOJbjJvoHy7sI+PVx5I0sH3A5KvydeUT13FSsAgaG/H94W46hAImT9so3FS0xcn7h5zhhQIOrfI20jmFrCEYBv2nmh+YVRCyVf82/qjwGkGl69O4BCRNDJD4=
Received: from VI0PR08MB11565.eurprd08.prod.outlook.com
 (2603:10a6:800:2ee::16) by DB4PR08MB8175.eurprd08.prod.outlook.com
 (2603:10a6:10:381::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 18:36:38 +0000
Received: from VI0PR08MB11565.eurprd08.prod.outlook.com
 ([fe80::78a7:564d:926a:476e]) by VI0PR08MB11565.eurprd08.prod.outlook.com
 ([fe80::78a7:564d:926a:476e%6]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 18:36:38 +0000
From: Ionut Mihalcea <Ionut.Mihalcea@arm.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
CC: Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, Jon
 Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <Steven.Price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?iso-8859-2?Q?Jakub_R=F9=BEi=E8ka?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-2?Q?J=F6rg_R=F6del_?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, Kai
 Huang <kai.huang@intel.com>, Kishen Maloor <kishen.maloor@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Peter Fang
	<peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao
 Li <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Mathias Brossard
	<Mathias.Brossard@arm.com>, nd <nd@arm.com>
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Thread-Topic: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Thread-Index: AQHdR4vGYwq+r6xws0SEHqpBMDahkbbUiuw3
Date: Fri, 18 Sep 2026 18:36:38 +0000
Message-ID:
 <VI0PR08MB115655F1834CEA1262DC09FE88A872@VI0PR08MB11565.eurprd08.prod.outlook.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
In-Reply-To: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	VI0PR08MB11565:EE_|DB4PR08MB8175:EE_|WA1PEPF00009B3C:EE_|PAXPR08MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: b60486ae-c8b8-4a66-4eaf-08df15b3db04
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|5023799004|11063799006|6133799003|22082099003|18002099003|56012099006|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 tC4PjbQiZ599miAH8Jch0O6HUnLMVqQUj5ek6oTjcpzNTLIFSGgpb74vKbFcfUShedo/l+A8YHrvtw8T/4oZdLDSgRXg9C9wRWr9uGMlTrskfmet1xvyW7rhDC8Dnh3NJUaAW7gboglC/KBvmwniQAghnsSvBC55XgtMZu4h8U6iIW71WeDXFFY2lKhI0RsfyzHyV3xiLTTV2JO4tkAvIbjJ+Agxx7JL5NFyrXzfwRsmj3UClk1FdWq1uhcKL2JbMbGswTd3U2eBX4kkTkAmzHSOmoiMbKFobHJUrQBKWxANRW4VLuCuKQs/MN8ecyiTEjG0qvJMcZlyoqGAwsQBmVayGkZElNdj1ynhqL3/wWDkSfBfTq5MPnJisPSh66GwKLy6wOdb/xaQx86LdHWmKDwGAbhN6TqaYVYsXp1i5l11kmbZ2Vv2l+RCsX8/KSqLmxpKaNJquWWHwRxAXhAjvscV8juVy0xKPkoSsI4zFy4PKbFHkT2l9dfpAhhZbdLxEUF8DXZU0UaKAMIP+N/jZPbxYrXFwQYOs8GCqeZOSs4kj5cPa/HIYomZLbmVIC0MFYXsQSFTAahpTWXsXTTWzQkHIzSufrDS2LBlgiZoL3R3fmSySEwGuB+zDJ1pHZfbpCq8UWy85hpRRTwQ00BVGcZASFhrJjF1qhmXKXMyWjI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11565.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 nouCPSMlysZ9yJM4XRJ8MKSqR3kDJP8abEkMPXUlSccyoa++bYQR5MkpOB3b7HNwLdw+IfTWscDoyLHAMA/zoqAH+VawzaBXAKm3HwigYYyKCV82TWuKRlRK5CWrdKuxKoZ0y8zxfhUY/FvztEh6Ij5PXkTi9PAqXAp4hnyhXEAq1jbIQfJIF63wOIHWI9gwuiZKBBh6uqFLhT1K11u65OD77p0+XbfeFgvAbRBf87rc99QksKYgxqBNhGoPD72KWRnH7IQeDf60WhinOhldSD54o1J8UuIJbs6WyvxZhSAX1lZJHojcKSh2FMir96EaHxCEMr39c9P+Ze3Jh2dn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8175
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7b73522e-689f-43cf-9cfe-08df15b3c6a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|14060799003|376014|23010399003|36860700016|35042699022|6133799003|22082099003|18002099003|13003099007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	AAVRAAL9pEEz2WY+iCUFDgCuq11ZLnSLMX76PABfWkiBEsZCrVuB04kozQcaik2SCaVBqEn8/MW16xCamVcbJSsYyZgRWbgDiC2WfuHg5Zv9aWfGvzeAWqLuL+WVE6cqJNil0P14Z5W2/f/+jpu7a6O6RocrOcQzzXs6ouXW667+9cv+g7yLJG9GbO2VXMxEr7a7IEeqWxhOPULpQcThqXArH8zozoKXNG7jTU/FCnPAXUHyTgLhB9jp4E75xJ7ONoWyHLiA1YtmotpeRbFqmOUo5UZ40+l61sbGYJQzE25OgLFEBC/cuT0GV4HI9oXf/nPKWsq96G4GiiR8ro65B15+s9AiqTLJaEM7Dqns77uVPJMvrXbb9OrD6gz/j/Gk6hoMa0xHQyHPn9Ba48UyRqitMrqWCrHWJfnj7EGnlnS6CUXRZ4BdV4WsSsOMlbeVu7qYZG89DvP4WozCoGBZhnQIetTAGr6Q4jdJ/3Wq5WvEBIbPpy0GPeEcHIgbXePTDchM6CmI6JhO7w3/tETtoNCjFMkvmQ88C6Qj9ae0P/xOlDENsyGcaQrHIEs2u7QaYNEThmnFYomlEwcp69qgF1kP9ndS+rEQpNRAvORKycbu7wpE3WBzOWZk+sjSoP7adiljCIVOrdxAFb83hcil6g==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(14060799003)(376014)(23010399003)(36860700016)(35042699022)(6133799003)(22082099003)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wAAOmSTyVX6JXWO0MRlocu2DF27X8A1ODY3Hr3XMGyoqypulDZ7u/yLElzwZtm12Jj9ImfUyecL226LvjgQCL1TIH0i860DZnQ9LSm5uofR0JRj7A+xTnO+3EcXBnPMX+7v5LkEdtiV7r2R/nJOE69ILWQCwWu9nICuxiQ6rm+kIqKr3ZliPYdH16H1jp/7zRc+skX20ixsb8UtyvLXNXsvkC8Qkl5SU+vJt0yH2ULyBgVZ6/P1+9taV8BISJuqg4qTEnalWQ0a2kjeIKOgbwWvzNPzT1mZPAmXwzwvBQmTiPbmKJ5mCsfXnvn7PVmu4OuzYS64G3SX6BDMIOxbytiRB/VabsKs2v6MvsBnKB2iuyUyd3a1dM/aNZIA4SfqaHGoZtfIlmpclfN0fF4yaQUtTeT45zo6gqtF8edpZ/ICLsSxffaMdbHm3RpTmB4iF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 18:37:12.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60486ae-c8b8-4a66-4eaf-08df15b3db04
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7419

On 31 Aug 2026, at 08:13, Tony Lindgren <tony.lindgren@linux.intel.com> wro=
te:=0A=
> Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration=0A=
> sound similar, can you please take a look how the API might work for=0A=
> SEV-SNP?=0A=
=0A=
While the x86 implementation is outside our scope, we're also currently=0A=
investigating how the Arm CCA ABIs for Live Migration ABIs would fit as a=
=0A=
backend for this API. We will provide more feedback on the API shape and=0A=
semantics as the analysis progresses.=0A=
=0A=
As an intro to our approach (and a potential touchpoint on the topic of thi=
s=0A=
API), Mathias Brossard will be presenting Arm CCA Live Migration at LPC nex=
t=0A=
month [0].=0A=
=0A=
> Dirty page tracking does not add a new uAPI. Userspace keeps using=0A=
> KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.=0A=
=0A=
One concern we currently have is about an impedance mismatch between the=0A=
non-CoCo dirty log APIs and our approach to dirty reporting. This is just=
=0A=
to highlight the concern at the moment, without any explicit proposal as=0A=
an alternative.=0A=
=0A=
[0] https://lpc.events/event/20/contributions/2476/=0A=
=0A=
=0A=
