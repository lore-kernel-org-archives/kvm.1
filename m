Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF813CE4BB;
	Tue,  7 Apr 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775585491; cv=fail; b=SqClK/X9LnAjScASIHK/s9mCGg/f0QUMeMQ7yYdBAianlxt1HPCY18PKovq+oY+HP0EcpuTGw/3papTBXE388NNaqXp9ZbU5Id7xeXcHjbnzc6lbnHrbj7F2KRds835t4nzRrYcm2Uzyjm5Gw7IgIRT3HncXfu94WyI7Z0vT8x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775585491; c=relaxed/simple;
	bh=DQBhhQqN/+KR0dc/ke+iOjbjnajUyCfr9e3SsTsMIgQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lSiLiO1z1VmU29qqNwhbFLbVfAZCkIf1AKF6oZOA0s44tljIL0QG3xmwx1R20eOKGuzBrd62Fepuq16iJs3n+0GHszEW6myou/sga4SMIcFoDvZYmViZwjD9UJsdNizTzEO8Hppb7wmGmuQ5S/vfQTscvu9oH6mN1PHW53JbxEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UAJeHAdA; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UAJeHAdA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBSC/5AKDR/5URz01VEE7Xdf9PTmBFWIDm/vnntnQhhBx2ObGoXezTp5vdcMvQ4oUr+taiX4INyuAQmT23kH5lDSLr2xJE8uHLSbmJz8Q1Mr4wi1y9jqd+9MYFau5i0Nm89aeL71867j7FcCYCDUGQexSRHDu6bdYA5O5hoZktrOyQsFV8C2+xZmwBT1kAFuU/Z9/6XDTpXvFpAfrOpGZWu5gVkGlhWzDIMALlawsMi/0Tc4dN6Uoqe/5LziNFTfBwXerYfVb4ZPz5RkZOI8aOSX0T8XPSjwcvZXCleGlvevdx0UG3q3YNgKjXG6eiCgvxi5voZ7cYDhgiRpmqismA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjxfC2z9L6LRZcn9aqmUE7kaopnFBbXB0eDR0VovKmE=;
 b=OcrcM4URo8VL6EZbEuHCgyRX4BrpcPW1NwSAIrENfG2Zfm6jP4dJe4IuJlC1I+Mh7Xt/bCJKqfNsG3yReIay5tl8QvGfMKV95AMztfj2k8RBsxSpQguclSbm1mNuwjWEt5i1E/aTTP9PdwrOjjLKY+mh+MO50mptF4AtkMkvY5isrRr6rU/C7Apu0WNtmwdijOzsYqouKMgbnQuuQiDRw5IKHdh66HNWYSLTuS8rWJtieetB+wJRj48qHEA8zObg8Dd/h1+hHpKLMtxRViqvb1Fm4TFGSTKhRVnqxII4TyA5J/WrqNQS9KWxt2q36MIyn8DYvu9KCKcdhDrPzl4FbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjxfC2z9L6LRZcn9aqmUE7kaopnFBbXB0eDR0VovKmE=;
 b=UAJeHAdA04yPM0C6VlCf2KIXwc0EKJs2Y2FLCAzJd56trZfp8llmJAnC4Jhw0iqCbopQo30HKfyI0uQqkJ96RkKVwrLrPDrChjecOUIxfL3zVRM4vy23CJAzUxEJCGxHOH20u6urmO0aVLaxo/ttqlL0q0snFc0ssn7sIpDU6EI=
Received: from DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) by
 CHXPR12MB999245.namprd12.prod.outlook.com (2603:10b6:610:2fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 18:11:28 +0000
Received: from DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38]) by DS7PR12MB8201.namprd12.prod.outlook.com
 ([fe80::e5d:5f41:954d:be38%2]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 18:11:27 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: kvm list <kvm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Cooper
	<andrew.cooper3@citrix.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Bug with nested PAUSE intercept on SVM
Thread-Topic: Bug with nested PAUSE intercept on SVM
Thread-Index: AdzGtpiRjeqXsvC5QHu6t6J5p0N2hw==
Date: Tue, 7 Apr 2026 18:11:27 +0000
Message-ID:
 <DS7PR12MB820101CABFA34E85442EA256945AA@DS7PR12MB8201.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ActionId=6b777731-8b2e-48e2-95b5-b6d5f10566d4;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=0;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=true;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party_New;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2026-04-07T17:46:03Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8201:EE_|CHXPR12MB999245:EE_
x-ms-office365-filtering-correlation-id: 152ccfdd-f8ab-40ae-6f2a-08de94d11666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 SuzzK23/7y7ynA4u7//U5bSeztfF8+M96t1vnrpnGbZJF5ExMef6stV0YojVVqbQQ1INtU/s6xt/+Os4/Bz6bK55wzOu2RCbEq/KKPIwDg8JnrTvNhoZxy+ZVF1uC1ANJQlqJ/FU0qoUaQ99pY7WhNfDqjiqqhD3f9BPMbI1jNzV1FGJiwuUWLg1sufy4cjeqxR1EB8ajscrXr1eG8u0h675LLzL+V8CRaWojpAhI2xqavHsL6IK3adSDudGIhQtuorYLXbFWTNZ928TczMAdaAspa1hVdSv3qKwgwX+umfD+yk+SJYQeKmaVwtnO9IU6iRTC8894DmBxDCASxuXBG0DOUnt9o8hoaaXnmdKVP3c4rHRXcdjWCRrumJwwYDRTwJFlo2RzoECBjdj8d4ZL3dcDmtyBOHFXKksh9EEBHFcjjh45+tMqktZBPHd2zzYpONpc2lPk8MnJJqLn3qnlPwEij3KbdECk0tta9f/s4J3eEYNnElBQxEqgOsouaeIzo+8EN1zcx7eWVoL+mhWXcQ/+ZyejnYLiE8IgVQcGUkWskH3x+zmHDENUw33Pxo1Ca5OKOHxTMGacPe4SNYEewLsuQnKOFKUJ7546xXtf/rs7ntK/KCviRWSKNlHIFLfsdsHDu/UiuuyWGY4JRvsPjzodO9jM7xVQv3J21ZW1wW0LEkl6FUsFZhL/yWlR7HkDhXE4YjSPecU8idQmQBZcbF2QrnIcPwjfmxDa/um6NKMQ6yiDv/F3Y21qi+oXjTmQf0WaVibocTE7PEKnpHqobAX+E5P6xZ4XKoWbRC6f6c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2cP+3nmw2wLCNz0S7gEB19/xMUH2G07he6zskrw+v7A0J+HUNfUJSq3gSOCj?=
 =?us-ascii?Q?qQAiLtHGfRKQEpxzj//i0riZRH6UJZSAUANhomzNtd5yl5ftU1QeE9vxi/wJ?=
 =?us-ascii?Q?xe2zvahS+t/10ru51kgpo/CIJBRV/GEp7dA53WUXqnkEBkzvRWqDRCZU6mGB?=
 =?us-ascii?Q?rQ+zbhhCJvnSUYoXRrghtcMvPK5VpyNy/NqIcXVuFDiJEr/ptNanaF+K6Ax4?=
 =?us-ascii?Q?tq93wtlUENsLnFAAlSu6Mi/NX9od50yDue4vSrtr+8wsnsgMHnuh5gZSkLXz?=
 =?us-ascii?Q?qbkdtJfn7LxhKCTIw53EzNXnvmwfTudjMFL+5G7yKEmBJvQtoCQln0guq9YT?=
 =?us-ascii?Q?ogf6t2yxsbdnVF8SnsF+krOI1Sz7vnc9+9orGIb5vNd8UuXUS/3AhxYWWRtN?=
 =?us-ascii?Q?BeDLyQWv9iRzpzROUsYrXIuq/75T9UzmRA4a6ndOm8ObjFj+02WM91vVBhwg?=
 =?us-ascii?Q?xiJ8utfrBtbGHYChSvONl9R4M8UV2j2oJkPsvdkrRKxffeZWMYibLj+m2DdH?=
 =?us-ascii?Q?dI2SdwQDpwHjmKoRxFEBhetgv8jLbbH+6oBujLTqLpYNy8l12HqQP6AwbyG4?=
 =?us-ascii?Q?3AfSlhwhRm/OP2t5U1C3SkwWyPMxKq9XqzK3H2r//LSFBH9h/47JNj7U1sEu?=
 =?us-ascii?Q?rTJPI6zO9/f/RE+MsCR/VSvsZXhUiHUf4oKdlcRuJ5D8Djtydix9Lw7Lpq2M?=
 =?us-ascii?Q?w7S3z0n9oa6RGEgz7xRO9qbBQVOfPO/XPZXfRAHgYWiL/Zvz6m1xfL2E/6HM?=
 =?us-ascii?Q?54DZN/PhZK8G2iHgdG2/bvO6XLOiWFxCVNJRNSkUuzotUlqGJqA6wSOcBeu8?=
 =?us-ascii?Q?mO+kufZEfPuZVMtMSmX5OMtPgUdEvEjyLnre4Y3hPRS716IjdTzTMIEVlVqc?=
 =?us-ascii?Q?c5HHjeXtM5OP2AKzuFFwDYEmG1z9Ymo8lPEW/LVyWpxpGr4uP0xF27GlC6ma?=
 =?us-ascii?Q?4nK9ixiu4g8Gt6hF/GB+ns6G9beSOhKW86eAhASm5NKxVdHyCeDBEklsqmST?=
 =?us-ascii?Q?8lN2RqI46z+mPnnFlDXAEZq1X7PRbJsnT2ln7Yz4lim2mHD3s5AiDZVKtBSl?=
 =?us-ascii?Q?Q/QPkY4iUqb/H7DrMkQ33NULQxvnG792GsHYAotFIgC9lljD/GlgEfuKN7v7?=
 =?us-ascii?Q?AOhATwA8o65HDejcXuTFAeRhWUPkWsA4qhVsHwCs9br0Hgt68RYrzImpFTvd?=
 =?us-ascii?Q?5miF2tDeYTS4XMxvDiQIs9m3fqgKv4TA3VhIExcFsG7z0RVtPIs1DPnMO3wv?=
 =?us-ascii?Q?ctbB0D1dOw3qjzS3tn6wZcuxeVh31f+/KPFKyfSJUHM1bwkCpAPcrx4MS+po?=
 =?us-ascii?Q?vnG8adUT0ZYqoUYUjfs6mOaaoMjoBWe5iAxYsPMRBa7J4n+2WvPM92AjQ0J9?=
 =?us-ascii?Q?SvkI+oh8cvoJc9kCxPe1QzETP7SjBXpBvE0/vShH2A9FAMGid2B3YLB7Qm2Z?=
 =?us-ascii?Q?fwkzlcNFx+4slo5VAunxnZe0vykYsJVzIqAgNJiKDiX+vVJBR8ju/uSFnGZi?=
 =?us-ascii?Q?NHDwofpsrGxKdBgEAd7owBPBX4MtyRio2CsfbXNWl0bpqfYFJ0lvFSend2rg?=
 =?us-ascii?Q?Bw9d0mEldo+zOmH0Vt26BnuoLE1+GG2/vWq+etke0i4Ur2+fS/fV/VrvqKGf?=
 =?us-ascii?Q?t1arE840GVM92SF025GE0XKQCG3CAOzJJEfxuNaioB6JHBunZYc8PQqiIghr?=
 =?us-ascii?Q?hq+X1qlVZ2RzpkRs5D3lvp+vQNMKGA6W8jMTeHs/pkbJlcxB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152ccfdd-f8ab-40ae-6f2a-08de94d11666
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 18:11:27.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH98qo7Doc46vqQ4Xzd7PDbNXuueRNFZqB3Hp+c0OReM3YGN/itrxRmKPyVQBfnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999245

Hi,

On AMD SVM when the L1 guest is trying to intercept every PAUSE instruction=
 in an L2 guest, the PAUSE intercept sometimes fails to fire.  I have a the=
ory on the source of the bug and also included a short reproducer below.

In this scenario, L1 has created a guest with the pause count and threshold=
 set to 0, and the PAUSE intercept bit set.  I *think* the bug is that if t=
he vCPU gets scheduled out on L0 while we're in the L2 guest, then upon res=
uming the vCPU KVM calls shrink_ple_window() which doesn't appear to take i=
nto account the fact that svm->vmcb might be for the L2 guest and not the L=
1.  As a result, it looks like it sets the pause count to the default (3000=
) causing many PAUSE instructions in L2 to not be intercepted.

The code below (compiled as an out-of-tree module) can reproduce this.  The=
 code runs a trivial VM which does INC EAX/PAUSE in a loop and compares the=
 final guest value of EAX vs how many times the host saw a PAUSE intercept.=
  When run on bare-metal (meaning I loaded this module on a bare-metal kern=
el) the values always match.  But when running inside a VM, I see mismatche=
s like so:

[  854.354997] pause_svm_test: completed 100000 PAUSE exits
[  854.355002] pause_svm_test: guest EAX=3D112000 (expected 100000)
[  854.355003] pause_svm_test: EAX mismatch, possible PAUSE intercept bug
[  854.369108] pause_svm_test: module unloaded
[  855.189293] pause_svm_test: completed 100000 PAUSE exits
[  855.189299] pause_svm_test: guest EAX=3D109000 (expected 100000)
[  855.189300] pause_svm_test: EAX mismatch, possible PAUSE intercept bug
[  855.203689] pause_svm_test: module unloaded
[  856.042187] pause_svm_test: completed 100000 PAUSE exits
[  856.042193] pause_svm_test: guest EAX=3D106000 (expected 100000)
[  856.042194] pause_svm_test: EAX mismatch, possible PAUSE intercept bug

The fact that the deltas are always a multiple of 3000 (KVM_SVM_DEFAULT_PLE=
_WINDOW) seems suspicious, but consistent with the above theory.

Reproduction code below (written with AI help).  Compile against desired ke=
rnel version and load it to run the test.

Tested on AMD Zen5 CPU running Fedora 6.19.10-200.fc43.x86_64 with no speci=
al kvm module parameters.

Thanks --David Kaplan

---
// SPDX-License-Identifier: GPL-2.0
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/preempt.h>
#include <linux/uaccess.h>
#include <linux/bitops.h>
#include <asm/msr.h>
#include <asm/msr-index.h>
#include <asm/processor.h>
#include <asm/processor-flags.h>
#include <asm/svm.h>
#include <uapi/asm/svm.h>

#define TEST_MAX_PAUSES 100000

#define NPT_PRESENT 0x1ULL
#define NPT_RW      0x2ULL
#define NPT_USER    0x4ULL

static __always_inline void stgi(void)
{
	asm volatile("stgi" ::: "memory");
}

static inline void svm_vmrun(u64 vmcb_pa)
{
	asm volatile("vmrun %0" : : "a"(vmcb_pa) : "memory");
	stgi();
}

static void vmcb_set_seg(struct vmcb_seg *seg, u16 selector, u32 attrib)
{
	seg->selector =3D selector;
	seg->attrib =3D attrib;
	seg->limit =3D 0xFFFFF;
	seg->base =3D 0;
}

static int __init pause_svm_test_init(void)
{
	struct vmcb *vmcb =3D NULL;
	void *guest_page =3D NULL;
	u64 vmcb_pa =3D 0;
	u64 npt_cr3 =3D 0;
	u64 *pml4 =3D NULL;
	u64 *pml5 =3D NULL;
	u64 *pdpt =3D NULL;
	u64 *pd =3D NULL;
	u64 *pt =3D NULL;
	u32 exit_code;
	u32 pause_count =3D 0;

	if (!boot_cpu_has(X86_FEATURE_SVM)) {
		pr_err("pause_svm_test: CPU does not support SVM\n");
		return -ENODEV;
	}

	guest_page =3D (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	if (!guest_page)
		return -ENOMEM;

	vmcb =3D (struct vmcb *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	if (!vmcb) {
		free_page((unsigned long)guest_page);
		return -ENOMEM;
	}

	pml4 =3D (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	if (boot_cpu_has(X86_FEATURE_LA57))
		pml5 =3D (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	pdpt =3D (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	pd =3D (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	pt =3D (u64 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
	if (!pml4 || (boot_cpu_has(X86_FEATURE_LA57) && !pml5) || !pdpt || !pd || =
!pt) {
		free_page((unsigned long)pt);
		free_page((unsigned long)pd);
		free_page((unsigned long)pdpt);
		free_page((unsigned long)pml5);
		free_page((unsigned long)pml4);
		free_page((unsigned long)vmcb);
		free_page((unsigned long)guest_page);
		return -ENOMEM;
	}

	/* Guest code: inc %eax; pause; jmp 1b */
	((u8 *)guest_page)[0] =3D 0x40; /* inc %eax */
	((u8 *)guest_page)[1] =3D 0xF3; /* pause */
	((u8 *)guest_page)[2] =3D 0x90;
	((u8 *)guest_page)[3] =3D 0xEB; /* jmp short -5 */
	((u8 *)guest_page)[4] =3D 0xFB;

	/* Build a minimal NPT mapping for GPA 0 -> guest_page */
	pt[0] =3D (u64)__pa(guest_page) | NPT_PRESENT | NPT_RW | NPT_USER;
	pd[0] =3D (u64)__pa(pt) | NPT_PRESENT | NPT_RW | NPT_USER;
	pdpt[0] =3D (u64)__pa(pd) | NPT_PRESENT | NPT_RW | NPT_USER;
	pml4[0] =3D (u64)__pa(pdpt) | NPT_PRESENT | NPT_RW | NPT_USER;
	if (pml5)
		pml5[0] =3D (u64)__pa(pml4) | NPT_PRESENT | NPT_RW | NPT_USER;
=09
	npt_cr3 =3D (u64)__pa(pml5 ? pml5 : pml4);
	vmcb_pa =3D (u64)__pa(vmcb);

	set_bit(INTERCEPT_INTR, (unsigned long *)vmcb->control.intercepts);
	set_bit(INTERCEPT_NMI, (unsigned long *)vmcb->control.intercepts);
	set_bit(INTERCEPT_SMI, (unsigned long *)vmcb->control.intercepts);
	set_bit(INTERCEPT_SHUTDOWN, (unsigned long *)vmcb->control.intercepts);
	set_bit(INTERCEPT_VMRUN, (unsigned long *)vmcb->control.intercepts);
	set_bit(INTERCEPT_PAUSE, (unsigned long *)vmcb->control.intercepts);

	vmcb->control.asid =3D 1;
	vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_ALL_ASID;
	vmcb->control.nested_ctl =3D SVM_NESTED_CTL_NP_ENABLE;
	vmcb->control.nested_cr3 =3D npt_cr3;
	vmcb->control.int_ctl =3D V_INTR_MASKING_MASK;

	/* 32-bit protected mode, no paging */
	vmcb->save.cr0 =3D X86_CR0_PE | X86_CR0_NE | X86_CR0_ET | X86_CR0_MP;
	vmcb->save.efer =3D EFER_SVME;
	vmcb->save.dr7 =3D 0x400;
	vmcb->save.rflags =3D 0x2;

	/* Flat 32-bit segment */
	vmcb_set_seg(&vmcb->save.cs, 0x8, 0xC9B);

	while (pause_count < TEST_MAX_PAUSES) {
		svm_vmrun(vmcb_pa);
		exit_code =3D vmcb->control.exit_code;

		switch (exit_code) {
		case SVM_EXIT_INTR:
		case SVM_EXIT_NMI:
		case SVM_EXIT_SMI:
			break;
		case SVM_EXIT_PAUSE:
			pause_count++;
			vmcb->save.rip +=3D 2;
			break;
		default:
			pr_err("pause_svm_test: unexpected exit 0x%x info1=3D0x%llx info2=3D0x%l=
lx",
			       exit_code, vmcb->control.exit_info_1,
			       vmcb->control.exit_info_2);
			goto out_restore;
		}
	}

	pr_info("pause_svm_test: completed %u PAUSE exits\n", pause_count);
	pr_info("pause_svm_test: guest EAX=3D%llu (expected %u)\n",
		vmcb->save.rax, pause_count);
	if ((u32)vmcb->save.rax !=3D pause_count)
		pr_err("pause_svm_test: EAX mismatch, possible PAUSE intercept bug\n");

out_restore:
	free_page((unsigned long)pt);
	free_page((unsigned long)pd);
	free_page((unsigned long)pdpt);
	free_page((unsigned long)pml5);
	free_page((unsigned long)pml4);
	free_page((unsigned long)vmcb);
	free_page((unsigned long)guest_page);
	return 0;
}

static void __exit pause_svm_test_exit(void)
{
	pr_info("pause_svm_test: module unloaded\n");
}

module_init(pause_svm_test_init);
module_exit(pause_svm_test_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Codex");
MODULE_DESCRIPTION("Out-of-tree SVM PAUSE intercept test");
