Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022113.outbound.protection.outlook.com [52.101.48.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A171F36308B;
	Wed, 11 Mar 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239365; cv=fail; b=jn3/Xid4iuotaSKgxypAuSuogQ5Cd2BSNNEv+YN6cXZ0VxxA20Wwo0+d06IDnq/DQE2qeu354+B1dJibfw/y4PZqvuCNswPbhciRbhxdDsB+ECBw5zduwxvJwQJ0EHUv0H2DGIDd1UDPU9x6LEATcY/yQOLfeaWa+1x1Ua2pcdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239365; c=relaxed/simple;
	bh=gkqb67G/XahbSSrE91WcZ7uZeyCowUrJStaDngR+zjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m8e8q++6drUgGqakxPhi7+SppLipPFyJWWqwIb80Pw1o1rfv27MeaUus6uETR0rNSRW85f+H1qLmkpsY4FbY6mb24ajuOVCmYdCjL3yIY+91EODGjT7FbtcaFozGGD7/sGNE23ADZxpgAT8VvdO154jKwZiIymf5HkJHL3fiKvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com; spf=pass smtp.mailfrom=fortanix.com; dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b=cndqF4+E; arc=fail smtp.client-ip=52.101.48.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fortanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fortanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.com header.i=@fortanix.com header.b="cndqF4+E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVKhq50fTNm2v0Pv9/D8NXli9P5h3X3XNDkLRbf38ndf2rqjjv2kE6hDWUCSxgCHg8At/zlO8h7VKVButd6Iush2ZU45Xjfa0ExK3haInxgfJ1SFXuroI6O0oFQbPb65Y28VgnYer6rPTG6il9u0V3PTPY0jRd1Rnc1lAIx9qVcJF5r+I6Rs8dZ2GO8EsGAUM2MRj4f3l+wqe6nszYGNjtJuYqeTDW8wGb495bvzSADIP/Ri0A8a4ou1WEyPhfgDwwsfAxtXx3H4DmeY4Vda3GX6pfRgsMLKDVlZXbJx256ZFuhaW9nJ0QD0iq26QeSwb1VgI/MWURHtJXNgoxGcIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp82t40KJSZ3glQ9dNXBKgmgsZ+MoyVXVSX0bivS1xM=;
 b=NISitP0vTO6Imc3nQF5vua4KoShJQJRdM8w8DowpsgsLx9LNzeCi42LF0c+yGHaFRPnNQ/u1v7Axs9azC1p95HXLimfJd+08cVCBKwNx2VKE0nKARZquaRcCngUZvzkjgijJpOltclBadDDbvqUVuT1T3k1I5ukdestzaYzKx9TOBcyBUA7EjIwffmpRLqW/NSG+VI1nIk3P/RbTSPouwbUc2xrM9ZPQxrKqDLKUW3tFGRp2CUU/7PTzkVVTvnz94nVxFo4/ypSdX7aFqi3xyMtB9LGifeekyzu2V3lQ3P+CUol9F3P4nt0Abl2dnBpZdC9OEnNOXfw2LMxtGV+HAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fortanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp82t40KJSZ3glQ9dNXBKgmgsZ+MoyVXVSX0bivS1xM=;
 b=cndqF4+EZqJ9FOkJcqUL+b2Tr/S697RwCrfeDol7bac4dxrc8Ql6bJyS7LCAmUTrNEA9cd3w3/iPX2Fi+D0lS8Jjopz8O+qyJ2MP3QCysEAnGCGpwMLnARBiDyD38c/kR8lBHzNDzKFvebAr44nuZHliM9AMoUOaABtPXp49KZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fortanix.com;
Received: from PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 14:29:19 +0000
Received: from PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80]) by PH0PR11MB5626.namprd11.prod.outlook.com
 ([fe80::64f2:5af6:ec99:cb80%4]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 14:29:19 +0000
Message-ID: <08c7e1fa-c78f-4c6b-b2cb-baf7233e681d@fortanix.com>
Date: Wed, 11 Mar 2026 15:29:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] Fixes and lock cleanup+hardening
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, =?UTF-8?Q?Carlos_L=C3=B3pez?=
 <clopez@suse.de>
References: <20260310234829.2608037-1-seanjc@google.com>
Content-Language: en-US
From: Jethro Beekman <jethro@fortanix.com>
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050607090609070604080102"
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To PH0PR11MB5626.namprd11.prod.outlook.com
 (2603:10b6:510:ee::15)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5626:EE_|SJ0PR11MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: e63304c5-9188-496f-fb21-08de7f7a94a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	t59RICtmNTYk+SCSGVCWiZ1lAsjHaBEMi3a4A6RNLKxQKrARUW+SaxZhu7BvHDfVy1aZZaUxnrcxDmFYvt7L4TdgmTfhL36XrrBmKWWKAWBhiDLAU8Kl15PBRpBBthwiiDpS3AfgL70xKJlJ+gyFEwcfaxUhQIIdZFjhXHqVGiMZIGWO5ALe1h+6X/mSFqzYhW8eAX3XCj6Z7lvBk0zzJyBrqxW9ZBqIXe4zEk1B8RLwfrv2Zun5ExHSWeI5ClMMTTq2mmMxFub2EG6elu9ANxAdKKDuaAvbjZAz7JcMO2j/r2JAPL+UbjzM2xKaYO3wkyJKj/pcBataBKxroKnOqEg4arKkUJRhRHDc0kP1jpRQ/JdpXfBcvo5Uqw8LyRJqfQ8bCjWr1iEtrbNejJUKbtrShEJoeWhnQHhQvDrdIPRy/D5lgQ0UQ+ByWrZyNymZpwRms7yYIp9/GmYO6SRL+Lp1uBfanxwNQowPbonZmKwFd8nUqz0VMmASrGRmooj/Bga/fRy0qm7pk/tlNgiYM6IaniFO88eQhk1FtBaXs15UZXldOymugB3xyQAiu0w77wgnpHrR9fvBA6rthWZalSlD1Lqz4QeQdS7zCL72xJOzgWeX5wNZESDq5aC/Jjllmhj8EfMxEVw9W/JCpku5LgjSc/+N/To7GWuzOMzY0juM/RUYA+bg/p4/kyJUVkPhgK+BSslcIW5H2pryY/4SR3jh8gSLCutczy/pcNPYAUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5626.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUs1ZHI2T1E0UGtFdTN3SUpod1JSY3VnVUQ4UEppcEplYUxPdllmdTNHL2hK?=
 =?utf-8?B?bUVGaEp2WW4xMW1XM1AxWGdRUUZOOUx5UytIaGxRbUFuVlp1T0VmQnRudkdT?=
 =?utf-8?B?YnUrckVtMUx2Y1FWM1BlSkhLTERzdGpiMFVzeVo3L1k0VDBNVmh6VVVwdkpp?=
 =?utf-8?B?YUZKQkZBSmNWNFBEYzAxajBsTjV1L2R1VG1Zb3pocGRrOEw0SUJuTEVQTS9r?=
 =?utf-8?B?QjZlTHVEZ2dta2lVTEpjVFlsQ2VBMzhwQzk2ZWsxMEw0NmxHTkE0blppV3Fx?=
 =?utf-8?B?MlBmdUYwbzE2L0ZqeUpZMFNhbzVqM0cyTU9nT3Z2dmhBWVc0WENSYjhJU20v?=
 =?utf-8?B?RXRpZ1lmdm9xUUdvQVVxZDJjZXVINTE3SjhtL1dyWFQyK1JXMDN6eDJZa2Nw?=
 =?utf-8?B?TmYvR25iQ2I2WUZPTzVHTU0rRFVRNjVSMmdPdm5GUnJOV1NhK05vbWVMZmlz?=
 =?utf-8?B?UGVCLzB3Wnk0TFVaU2VlZjg4RDN4TXVTb0FKYStHNkpPM254a1EwMWY5RW83?=
 =?utf-8?B?YStFUFAzaWMwRVVkUG94cTFDT2JVbkRTbWYwY3J0cE5pY1V5NFpmYVExS0w4?=
 =?utf-8?B?Q1EveDhYVWJsUVdPaTdxZzVlZjNzM0dLTjErK1ZMYks5bFJWTnNEejcyTE5y?=
 =?utf-8?B?NGhYVVRBTzdicXliSEUxRlI2K3I5cVpTMm1lYXJLUTFKZWpMK2RVN1pyanBX?=
 =?utf-8?B?b0JDY2IwZklHbjMyMmZudWxycENnR2E5dzF5TjFvY3V5czZrS0FHaGdZZ1Z0?=
 =?utf-8?B?S1hGMENMZDRYK0VIS3JUczBCMEhqMWsxN3VBQ09WdCtyYzJ2WTBoTGwrdTY3?=
 =?utf-8?B?WDBZUy9oZXhLMDVibTErK0xyNVY2UlN6Q3pVcnd4U0VQL3FIZzkrQ2V1djRM?=
 =?utf-8?B?V3RkSkFDNEdCNHdQUU40TFAxRkUzcmFpc1FQTlFtMmtaTFJTL3RsNTRQSTAy?=
 =?utf-8?B?clpoWGgvNmd3RUlxRENJNXhkWUo4NW1NL00vd2p4WGZ0SnVwMzl6UVcrTmds?=
 =?utf-8?B?YUthTUpEMFBUSjR5aUZ4NUpHQVFSRENSWm9aL0lsUTJxcjhSZndleWdJckJo?=
 =?utf-8?B?YjFKb2g5ZENlKzhJK2xUbFRzN1h6cEJFR2xNOC9TNnBLMlpUTXQvMit1dmt6?=
 =?utf-8?B?YXZtSWZYNUJTVDM5eHBtTmJaeTBpYTFoQVNNdzVGb0dwRUcrZExYNjlVb2I1?=
 =?utf-8?B?R0hJYXQ3U1I4Rk1yZTJ0b2pnNXZPNVVNOUJQWXhLVURSOFlSTjRwb2tRdjlu?=
 =?utf-8?B?azRVb3I1VWpkK0JMMUxjQm5IZnlQWnJNM0FjbElBbkxVTC9oZmQ3NDF1T1p4?=
 =?utf-8?B?akowRFJJNmZpNWFSQU5YUHNGMGptcTRJN0czenBtQ1NuTmhlYlJULzgvN1l1?=
 =?utf-8?B?N1VkbmF2bDlBdS9oM0dXZ2NqZU03eXNrT3BDSU1RTFlUYmJZZGlWQzFKUTBK?=
 =?utf-8?B?bWlOMm9Sbjltd2pMSFhINWxsRWdSZHhUQldyTmVQS1dDeW94UTl6OURCRElq?=
 =?utf-8?B?MnFZR1F2S29WcTV6dmszNG4yV0JzdFptSEQ0WUtkWU1xczhVeUhVd0h1TmV1?=
 =?utf-8?B?RFBQc3o5TmFFaHh2bU80U0VsQkF6bmlCVll3SjVsT3R0VzRQMWVwOFhhL0Na?=
 =?utf-8?B?RFNTYmE4b3dzM2RSMzRKT1lLdTk4MXprcTQxQWkyM1BFbDdRM2pkM3ZocEFa?=
 =?utf-8?B?WHo3d1Q2L0hwTFFWRElNSDhONE9JUFl4Z1hTVmdtdTBrL2VkUnpIOXpQc0tq?=
 =?utf-8?B?TTJ4WEErMUt2YVRwbXQwenJoTndjVXhvTG5JSHArZ2laNmQvNm9pV2s1bDlG?=
 =?utf-8?B?Y2lJQ2RPZVVONGtBMUxnL0poVHVYK3MxVGlpVGlWcHB0ckI3NkZUdDJudUEw?=
 =?utf-8?B?SGdtUlp5dER3QUVabVV2ZEJUbGJDZExRby95NmNpV2NXaExpMUE4Q0Q3L2Zk?=
 =?utf-8?B?V2JrS20xZTgwUEJIb0h3VXlZbysyMFQ4Z1BHMmRHZklRNTl5L0xCR0VKR2Ra?=
 =?utf-8?B?eURSN3hZSk1DNE1heHo1MFQyZlZZZE94SE5jYWxLQkt4RjVCVEE2RWZ3SjNO?=
 =?utf-8?B?TzVuekVmUHl0NWk5QXZERzFMakNEcG8rdU5tT1B2ZDY5T0NxNUVVUDZCM29j?=
 =?utf-8?B?cUE2NjgwUnA3TWl5b1hnRDVqSmRQOVo2d3FTc2lZcGtydGxVUEtiT3dacVJX?=
 =?utf-8?B?eG1wbTR5M3Q3Qk9pWW1pcWhaQ1J3c3JyZE9sNzIzYzBjWjZxdThxY3Z0NExp?=
 =?utf-8?B?VFdDazBYUUQ4UDF2VlJYMHhDdVloMDNGeWVRWDBUS25UbjAvUCtENS9yaUpE?=
 =?utf-8?B?MHRpMFpiK0kyL2x6Q1N4cVM5VmlWa00rUGNhTGhBSXE5eis0L1huUT09?=
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63304c5-9188-496f-fb21-08de7f7a94a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5626.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:29:19.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBwRPZtdqr/mSJsTbTp4Grru+64N/UwHkgpipX93eHYRKZAnxcJwebHo0XcV6yken/YCOpIrJlNrflcg8HpiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007

--------------ms050607090609070604080102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-03-11 00:48, Sean Christopherson wrote:
> Fix several fatal SEV bugs, then clean up the SEV+ APIs to either docum=
ent
> that they are safe to query outside of kvm->lock, or to use lockdep-pro=
tected
> version.  The sev_mem_enc_register_region() goof is at least the second=
 bug
> we've had related to checking for an SEV guest outside of kvm->lock, an=
d in
> general it's nearly impossible to just "eyeball" the safety of KVM's us=
age.
>=20
> I included Carlos' guard() cleanups here to avoid annoying conflicts (w=
ell,
> to solve them now instead of when applying).

I wrote a bunch of tests (see below) to check the kernel can properly han=
dle bad userspace flows. I haven't had the chance to test them with your =
patch set.

test_vcpu_hotplug() triggers dump_vmcb()

test_snp_launch_finish_after_finish() triggers the OOPS I wrote about ear=
lier.

All other tests seem to be handled (somewhat) gracefully already.


diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/tes=
ting/selftests/kvm/x86/sev_smoke_test.c
index 77256c89bb8d..93339420b281 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -160,6 +160,155 @@ static void test_sev(void *guest_code, uint32_t typ=
e, uint64_t policy)
 	kvm_vm_free(vm);
 }
=20
+static void test_vcpu_hotplug(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu2;
+	struct kvm_mp_state mps;
+	struct kvm_vm *vm;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+
+	vcpu2 =3D vm_vcpu_add(vm, 1, guest_snp_code);
+	mps.mp_state =3D KVM_MP_STATE_RUNNABLE;
+	vcpu_ioctl(vcpu2, KVM_SET_MP_STATE, &mps);
+	vcpu_run(vcpu2);
+	printf("test_vcpu_hotplug/vcpu_run returns %s\n", exit_reason_str(vcpu2=
->run->exit_reason));
+
+	kvm_vm_free(vm);
+}
+
+static int try_snp_vm_launch_start(struct kvm_vm *vm, uint64_t policy)
+{
+	struct kvm_sev_snp_launch_start launch_start =3D {
+		.policy =3D policy,
+	};
+
+	if (__vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_START, &launch_start) !=3D 0)=

+		return errno;
+
+	return 0;
+}
+
+static int try_snp_vm_launch_update(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
+	{
+		const struct sparsebit *protected_phy_pages =3D region->protected_phy_=
pages;
+		const vm_paddr_t gpa_base =3D region->region.guest_phys_addr;
+		const sparsebit_idx_t lowest_page_in_region =3D gpa_base >> vm->page_s=
hift;
+		sparsebit_idx_t i, j;
+
+		if (!sparsebit_any_set(protected_phy_pages))
+			continue;
+
+		sparsebit_for_each_set_range(protected_phy_pages, i, j) {
+			const uint64_t size =3D (j - i + 1) * vm->page_size;
+			const uint64_t offset =3D (i - lowest_page_in_region) * vm->page_size=
;
+
+			vm_mem_set_private(vm, gpa_base + offset, size);
+
+			struct kvm_sev_snp_launch_update update_data =3D {
+				.uaddr =3D (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
+				.gfn_start =3D (gpa_base + offset) >> PAGE_SHIFT,
+				.len =3D size,
+				.type =3D KVM_SEV_SNP_PAGE_TYPE_NORMAL,
+			};
+
+			if (__vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data) !=3D =
0)
+				return errno;
+		}
+	}
+
+	return 0;
+}
+
+static int try_snp_vm_launch_finish(struct kvm_vm *vm)
+{
+	struct kvm_sev_snp_launch_finish launch_finish =3D { 0 };
+
+	if (__vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish) !=3D =
0)
+		return errno;
+
+	return 0;
+}
+
+static void test_snp_launch_update_before_start(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	TEST_ASSERT_EQ(try_snp_vm_launch_update(vm), EINVAL);
+
+	kvm_vm_free(vm);
+}
+
+static void test_snp_launch_finish_before_start(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	TEST_ASSERT_EQ(try_snp_vm_launch_finish(vm), EINVAL);
+
+	kvm_vm_free(vm);
+}
+
+static void test_snp_launch_start_after_start(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	snp_vm_launch_start(vm, snp_default_policy());
+	TEST_ASSERT_EQ(try_snp_vm_launch_start(vm, snp_default_policy()), EINVA=
L);
+
+	kvm_vm_free(vm);
+}
+
+static void test_snp_launch_start_after_finish(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+	TEST_ASSERT_EQ(try_snp_vm_launch_start(vm, snp_default_policy()), EINVA=
L);
+
+	kvm_vm_free(vm);
+}
+
+static void test_snp_launch_update_after_finish(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	TEST_ASSERT_EQ(try_snp_vm_launch_start(vm, snp_default_policy()), 0);
+	TEST_ASSERT_EQ(try_snp_vm_launch_finish(vm), 0);
+	TEST_ASSERT_EQ(try_snp_vm_launch_update(vm), EIO);
+
+	kvm_vm_free(vm);
+}
+
+static void test_snp_launch_finish_after_finish(void) {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm =3D vm_sev_create_with_one_vcpu(KVM_X86_SNP_VM, guest_snp_code, &vcp=
u);
+
+	vm_sev_launch(vm, snp_default_policy(), NULL);
+	TEST_ASSERT_EQ(try_snp_vm_launch_finish(vm), EINVAL);
+
+	kvm_vm_free(vm);
+}
+
 static void guest_shutdown_code(void)
 {
 	struct desc_ptr idt;
@@ -217,13 +366,29 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
=20
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	if (!kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
+		test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
=20
-	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
-
-	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
+		if (kvm_cpu_has(X86_FEATURE_SEV_ES))
+			test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+	} else {
 		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+		system("logger starting test test_vcpu_hotplug");
+		test_vcpu_hotplug();
+		system("logger starting test test_snp_launch_update_before_start");
+		test_snp_launch_update_before_start();
+		system("logger starting test test_snp_launch_finish_before_start");
+		test_snp_launch_finish_before_start();
+		system("logger starting test test_snp_launch_start_after_start");
+		test_snp_launch_start_after_start();
+		system("logger starting test test_snp_launch_start_after_finish");
+		test_snp_launch_start_after_finish();
+		system("logger starting test test_snp_launch_update_after_finish");
+		test_snp_launch_update_after_finish();
+		system("logger starting test test_snp_launch_finish_after_finish");
+		test_snp_launch_finish_after_finish();
+		system("logger all tests done");
+	}
=20
 	return 0;
 }


--------------ms050607090609070604080102
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ZmljYXRpb24gQXV0aG9yaXR5IFJTQTAeFw0xOTAzMjYxNzQxMDZaFw0zNDAzMjIxNzQxMDZa
MH4xCzAJBgNVBAYTAlVTMQ4wDAYDVQQIDAVUZXhhczEQMA4GA1UEBwwHSG91c3RvbjERMA8G
A1UECgwIU1NMIENvcnAxOjA4BgNVBAMMMVNTTC5jb20gQ2xpZW50IENlcnRpZmljYXRlIElu
dGVybWVkaWF0ZSBDQSBSU0EgUjIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDm
Q+3UxwVE9dAx75DUrLZwgASWLLr/ID8bbGCfpcrSHIRsrR4ut5n49JGViu5DYE6addkpajbi
MA2Jaw1Ap4RncDjZ+0fzSWbqGKEE+vNPVLoKy7OVIrxf/9HzGUT6YaELSNrGTR0cYNcR+W5b
E3JTxTMQiLMAwBbMXH4qKXQUT+oyIXD11CIMUtM8ECoo2o7qdpw1zaZWwVvhXy9mkAaRgrkw
2NpddZUVbJKF/spsJa3lNVdSi3wcJpDDQAl6jxtBF/3ctkY1OjBQz32yRlArFymsPc+we9ff
HAgvfqbHVfXvgWG8urVith8/6MjmojHMCKqFoJueLbtTPoN8QhvVh49uoRYYAUUH0HOAYCOz
GBGrdJvMIYZqQsX90XlU7Qxp1En7vMkQswkQTvGmBPWrK/EwSAJc15BZm+i8QBxPqVKFORfL
ETLEC4ZrwomtW/oPxBP8zXPvQ0K1dQzAkw+JXxKv/KiwDryFFhU5xMMB3yKxO5NRYXlnqW9n
wfhdBTJScthzAtGO9KZQ2GPmq0NMVMuXe1XdCOmnPxOptKkMldBItkaYgrkTzqP1nzIAhVfU
4sNnHIxKPftwrZ9VMSc5Wkz88bOtAJyz3KQRY0qcAtR4LaeRkiZaEmprQA8EOpdJxtv03pBZ
taUnnTY6DsEwGQ0+P2mmB5IHB74SknyNswIDAQABo4IBaTCCAWUwEgYDVR0TAQH/BAgwBgEB
/wIBADAfBgNVHSMEGDAWgBTdBAkHovV6fVJTEpKV7jiAJQ2mWTCBgwYIKwYBBQUHAQEEdzB1
MFEGCCsGAQUFBzAChkVodHRwOi8vd3d3LnNzbC5jb20vcmVwb3NpdG9yeS9TU0xjb21Sb290
Q2VydGlmaWNhdGlvbkF1dGhvcml0eVJTQS5jcnQwIAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3Nw
cy5zc2wuY29tMBEGA1UdIAQKMAgwBgYEVR0gADApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYB
BQUHAwQGCisGAQQBgjcKAwwwOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDovL2NybHMuc3NsLmNv
bS9zc2wuY29tLXJzYS1Sb290Q0EuY3JsMB0GA1UdDgQWBBRmj6a8t5Msnfm6SeVP3OqQUBFq
nTAOBgNVHQ8BAf8EBAMCAYYwDQYJKoZIhvcNAQELBQADggIBAMJr11ncGIPKbaZxuuU2P1TG
yXF+gy+xH2TBNWNliJVL613nH1J7L2WcJQzqXYl77rKTzGeQexnKeYZ13MFwuE80vISif/gw
K569WLoyCvNVvGEZ2bZ+JL5K49mVhrv1gqO+MgMvc8iEENl1xoWRpJGD4EClk8t4u7NUCgBv
hYORiyzHCZcILHcEMvfEwmmFshMN6TqcAJdRjFT0Ru0hJcs5d7EFdM9dCa5ckXWrKK49cSNq
4qOaxqpG99EfDw6U2c70YcJ1/IhC1wL6z8qlGvhYQ0vJvqGJqW/DdeuWcMmrB+qZL9WbORQ1
nvlNggB6smEk0pXXYBr8HYjxT67XwtBBmkBXFpa7G6y4P0BO3kxWGBfvRBJHfyaiwREgVWa3
6V/WjXtPmV8VHcv04Rqgk64E4OlSUxgi9k9VC6kivTXJN+Gg2uJJBQdf+ptVhJqkkrtB0gAB
F+kQP0xsagKkrS3NVrVKo6peWMx0h7l52bGqT8ucu4Qe200KQi2xp/r8jpP60EE9U4M8D1gr
H3Kh9OxVOL4wykdoC/yGJNLKIl0BfsCVWB/GeSq5hxe/84K51OEJqpjDnOMrkRevfVzqGBFF
Aeg7Kg7uSysVR05wR+ltp3ytaIbjGJtKad8raIbM1qiNFErG7YB7v4baI3BP1s/rTDtPLoto
tahwHP7IqOHOMYIFVDCCBVACAQEwgZIwfjELMAkGA1UEBhMCVVMxDjAMBgNVBAgMBVRleGFz
MRAwDgYDVQQHDAdIb3VzdG9uMREwDwYDVQQKDAhTU0wgQ29ycDE6MDgGA1UEAwwxU1NMLmNv
bSBDbGllbnQgQ2VydGlmaWNhdGUgSW50ZXJtZWRpYXRlIENBIFJTQSBSMgIQNfphqrZnvSlG
TcM/9wjbxjANBglghkgBZQMEAgEFAKCCAxIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMjYwMzExMTQyOTE0WjAvBgkqhkiG9w0BCQQxIgQg/QS66lX3YiqN
z9TFRrPUrsr/Ht6dkXtqW7AJVc0tcV8wgaMGCSsGAQQBgjcQBDGBlTCBkjB+MQswCQYDVQQG
EwJVUzEOMAwGA1UECAwFVGV4YXMxEDAOBgNVBAcMB0hvdXN0b24xETAPBgNVBAoMCFNTTCBD
b3JwMTowOAYDVQQDDDFTU0wuY29tIENsaWVudCBDZXJ0aWZpY2F0ZSBJbnRlcm1lZGlhdGUg
Q0EgUlNBIFIyAhA1+mGqtme9KUZNwz/3CNvGMIGlBgsqhkiG9w0BCRACCzGBlaCBkjB+MQsw
CQYDVQQGEwJVUzEOMAwGA1UECAwFVGV4YXMxEDAOBgNVBAcMB0hvdXN0b24xETAPBgNVBAoM
CFNTTCBDb3JwMTowOAYDVQQDDDFTU0wuY29tIENsaWVudCBDZXJ0aWZpY2F0ZSBJbnRlcm1l
ZGlhdGUgQ0EgUlNBIFIyAhA1+mGqtme9KUZNwz/3CNvGMIIBVwYJKoZIhvcNAQkPMYIBSDCC
AUQwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzANBggqhkiG9w0DAgIB
BTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAHBgUrDgMCGjALBglg
hkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgQwCwYJYIZI
AWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQMEAgkwCwYJYIZIAWUDBAIKMAsGCSqGSIb3
DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgGBiuBBAELATAIBgYrgQQBCwIwCAYGK4EE
AQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYGK4EEAQ4BMAgGBiuBBAEOAjAIBgYrgQQB
DgMwDQYJKoZIhvcNAQEBBQAEggGAg/ytp2woaKClLX51bqWcLUonXOCYTT+cBz29PMgZR+Er
2bDZbDA7j1tclg5uQGXbZNz0m31/gPTDfrLmnloglvArf0A2VqWFDJsGx56Z9+xS1+fvR/U3
y3IF/Rpvqx4T07zgeZxf/kryPmV3PkVNeATQYFoQ9LwrvGYcrGvPPaERKGliIAbW2dC9J7as
GIXQ1QAtH38a1GCERaD47P9LS5wPkCyGeQCgqqX20CxAUDwrqZul6L3044K1PQNirA+YyGeb
R1L32on4SZ7A9t0yRBKuZFyzUSGIECKupTkgiVt82iFNUaFukVLNiTmJn07iRUcabrABmVnv
6GG/K/RIYj+qCpmuTXhzf0vEmlvXmMfWiNiQfqb4dNp23amak7rmUl36mdCZeZUO/YHyvcf8
Ixjeron7SrWhoPPRmKW4p0hD1S0mzri0gnuaG56aakYVWzNTf0cmpbnp0fWG94bnzwhNEc02
fV5lL6jVR8Y8ihXwo2Olzvt1RGmVSkyMGp30AAAAAAAA

--------------ms050607090609070604080102--
