Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B052264A9
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403138; cv=none; b=u5/TtVbnsOkpBE0lKO9xye914kLTT+MVjJ/LCSciv5kBNjq0l9oTkA/Pv/Q/Ce8A6n4zsanXQpe8Fw0KPFboenGOVwraIY2tt9cOUO74+sU460OkSE8EQUM9tEMFVcpC6E2A2h1yQicQw8J5URjjyyIG7TItl6j3+8INzqumm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403138; c=relaxed/simple;
	bh=aMAVCwYAzwgjRTTqaVNCL6KskGTUJHm3j8ZOolxqAAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/81e07K1S+JJaP4h4UHjU9LeLYHd2nNmH9kLKvLKcqkNvdd6A380mwKkfibQDKu5Z0GsEMlmwwQuSr8dRv+bdnxF6pLfMsYMREClRzCsYu6D7WeXegQcZh2Dllpam3zz0yRmJRaWllpqFRdo8rhb7S4R6Z4dNx8eldf9jyhhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAzXqqQU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lc+lA8Nr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAzXqqQU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc+lA8Nr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790403135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
	b=NAzXqqQUVXlfb24n/2ZL12qhZAksd0mf3ys9xDnJp5ElRksXkAnuFXvVlm/2TyLwxZMkG3
	x6mMSOHuC9EjHGd4tGIqJWohK8r1VOdL9erlb8C64MTH7HiMBbIg8bZIIltZBZwfaXsJ50
	0EfYJs6bt0ybIesi4xp9Sqr7PxrGOV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-tI7ddRs2M2WbDsOxkivEtA-1; Sat, 26 Sep 2026 02:12:13 -0400
X-MC-Unique: tI7ddRs2M2WbDsOxkivEtA-1
X-Mimecast-MFC-AGG-ID: tI7ddRs2M2WbDsOxkivEtA_1790403133
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ffe287240so625865e9.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790403133; x=1791007933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
        b=Lc+lA8NrvaSnBGceRrtej2dMos7EhHaKm4iwomvSVmzFj8KXXJiX4YUwlvjGvwereo
         3h/QdptFqm9CdH9vi1gLN2w/G8Cwy/LE3UdKXz+rtwHL5wtUZdPGQWSaINqIVxqrgNnY
         cLOsMmqobWqvfExmua1EPVT47TWn7qAZNXtfUv7hBpXe1fuOAg+eyFW/pqNaiu5UGsre
         ddst1rONPdh5KSgw0o4n+xWcsqPLSjfgmODz1271nh4r8Xk2D+BzEtPGeA7oeDrgSgrc
         BRVlhldjHajw4UlrFkOWXm1NbYABZd3AMPA+KfIp+2mIi9kpIeuAihss4cl5RHAPUANH
         c3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403133; x=1791007933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
        b=Ozt20JTNoPNpGx6DUC6fesXlmQg18Iyt4kmYNasCaDroR/UBUjLgYoJDL5KW8CoeXl
         th7BxbQyr1aje5/7xTDHmJsOrfEW1pnA0ASkFD47nMFa2Ut1V5x0qOT/pfpfHfuzAmxr
         QYWICZrOUNNcZ9D2HvQbyGTADV1zmy9SLKtbSN7yquyJN6+kVqUJ1t+qQtNZFuOxiqT6
         zUFpuOct6sfGHK23iDEB/XOwQhrTJWFfiyLuAkD/YZQN/getd9siBr5i0rboQVoI1yly
         YkLandHwveL5VxrigvnF92I7D9USFAx/dAnv+z1gDmsFKKZPmdGNrFQbK11wDgYSAUV0
         d1Dg==
X-Forwarded-Encrypted: i=1; AKwUvByyTpv0rnU5C+FqzEAMfLrh7Q04IBX34MNW66eSkK3t10wUhOWoB6jzm8MlxnXEBuVJVYc=@vger.kernel.org
X-Gm-Message-State: AFuF++m6QUx0er8nwG+Xe9cjPiOCTsM7bcbibhPpGtBdW3MLbYTVxZYF
	9KWs4kKwQfy5SDTbqZdYXLlZCS7yeiqb+0C3L8Zw2cWFQL6utlP+kPDWCwlzlhaad171HeQOhar
	i0UGpsgnwcIG0LUiRebSSUr96FY6aBuMHuewUM701wltWXQdjGw6K+3xDALedaw==
X-Gm-Gg: AYBFou24fwk+Ff9mRkh/GbTXV0WBwmrQur6sO64UcSNZ4OhHVy7oGui2FfD2RgsoK/B
	b1s1mnk/DjOJRKsSdEU3W5WHqAtMjLBGo+P0IEgpn3gF5M4lixiOy4jCM4q+WFKPjmjTE4K7gSB
	PKlTQH+xr4IQWztuvcWzOnVny3dfXeldgb6xKGAhpVr8neOO1Nwyazc/IR98JRPkTVB7wIRJuTG
	MlU9ud0P/XVIbpXx6mrST+WtC1OVzgqdr2HdN76gvgm79XswDaCSEo/yPqz4kmbylDh9zfIb2U/
	n7WG8YVSUHFsH4RcFnw72f2kJ3Hxm4CZ9lADQ9CT+1nSHtv4oHTUk1rwWm201ZreJad7tcJ+Qdg
	BA+oLjsSabUBPmC0x90aa4fZ40/0y8Y+cx5sRfyr6Qe31W4zt+6TsS02UFx/KprhPY6SVjHtBFG
	puDAKL
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49fe66f144fmr139782265e9.16.1790403132686;
        Fri, 25 Sep 2026 23:12:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49fe66f144fmr139781965e9.16.1790403132386;
        Fri, 25 Sep 2026 23:12:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm218640265e9.3.2026.09.25.23.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:12:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: Re: [PATCH 00/11] KVM: fix issues with stale control fields
Date: Sat, 26 Sep 2026 08:12:11 +0200
Message-ID: <20260926061211.714733-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Fix two bugs where the guest could do stupid things on purpose to=0D
> cause problems in the host.=0D
>=0D
> Patches 1-5 cover cases where actions done through VMCB control fields=0D
> have to be redone if VMRUN fails.  In particular, failed VMRUNs can=0D
> cause pending TLB flushes to be dropped.=0D
>=0D
> Patch 6 fixes a case where eVMCS execution controls can cause the=0D
> host to use a stale MSR permission bitmap.  Patches 7-11 are tests=0D
> for nested x2APIC; don't run them on an unpatched kernel.=0D
=0D
In addition to what was reported by Sashiko, the test does not pass on=0D
SVM.  Fixed as follows:=0D
=0D
diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/t=
esting/selftests/kvm/x86/nested_x2apic_test.c=0D
index eb89d5bfc0fe..ce204ce29a9c 100644=0D
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c=0D
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c=0D
@@ -48,6 +48,7 @@ static void l1_svm_code(struct svm_test_data *svm)=0D
 	GUEST_ASSERT_EQ(ctrl->exit_code, SVM_EXIT_CPUID);=0D
=0D
 	stgi();=0D
+	x2apic_write_reg(APIC_TASKPRI, 0);=0D
 }=0D
=0D
 static void l1_vmx_code(struct vmx_pages *vmx, struct hyperv_test_pages *h=
v_pages)=0D
@@ -80,14 +81,12 @@ static void l1_vmx_code(struct vmx_pages *vmx, struct h=
yperv_test_pages *hv_page=0D
 	control |=3D CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;=0D
 	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);=0D
=0D
-	if (control & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) {=0D
-		control =3D vmreadz(SECONDARY_VM_EXEC_CONTROL);=0D
-		control |=3D SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |=0D
-			   SECONDARY_EXEC_APIC_REGISTER_VIRT |=0D
-			   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;=0D
-		control &=3D (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);=0D
-		GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);=0D
-	}=0D
+	control =3D vmreadz(SECONDARY_VM_EXEC_CONTROL);=0D
+	control |=3D SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |=0D
+		   SECONDARY_EXEC_APIC_REGISTER_VIRT |=0D
+		   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;=0D
+	control &=3D (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);=0D
+	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);=0D
=0D
 	GUEST_ASSERT(!vmlaunch());=0D
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);=0D
@@ -103,7 +102,7 @@ static void l1_vmx_code_part2(void)=0D
 	control &=3D ~CPU_BASED_TPR_SHADOW;=0D
 	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);=0D
=0D
-	control =3D vmread(SECONDARY_VM_EXEC_CONTROL, &control);=0D
+	control =3D vmreadz(SECONDARY_VM_EXEC_CONTROL);=0D
 	control &=3D ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |=0D
 			SECONDARY_EXEC_APIC_REGISTER_VIRT |=0D
 			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);=0D
@@ -154,21 +153,23 @@ static void l1_guest_code(void *test_data, void *hv_p=
ages)=0D
=0D
 	l1_test_x2apic_intercepts();=0D
=0D
-	if (this_cpu_has(X86_FEATURE_VMX))=0D
+	if (this_cpu_has(X86_FEATURE_VMX)) {=0D
 		l1_vmx_code_part2();=0D
-=0D
-	l1_test_x2apic_intercepts();=0D
+		l1_test_x2apic_intercepts();=0D
+	}=0D
=0D
 	GUEST_DONE();=0D
 }=0D
=0D
-static void __test_x2apic_intercepts(bool use_evmcs)=0D
+static void test_x2apic_intercepts(bool with_inhibit_apicv, bool use_evmcs=
)=0D
 {=0D
 	gva_t nested_test_data_gva, hv_pages_gva =3D 0;=0D
 	struct kvm_vcpu *vcpu;=0D
 	struct kvm_vm *vm;=0D
 	struct ucall uc;=0D
=0D
+	inhibit_apicv =3D with_inhibit_apicv;=0D
+=0D
 	vm =3D vm_create_with_one_vcpu(&vcpu, l1_guest_code);=0D
 	vm_install_exception_handler(vm, POSTED_INTR_VECTOR, guest_irq_handler);=
=0D
 	vm_install_exception_handler(vm, POSTED_INTR_WAKEUP_VECTOR, guest_irq_han=
dler);=0D
@@ -207,29 +208,15 @@ static void __test_x2apic_intercepts(bool use_evmcs)=
=0D
 	kvm_vm_free(vm);=0D
 }=0D
=0D
-#define _test_x2apic_intercepts(inhibit_apic_setting)	\=0D
-do {							\=0D
-							\=0D
-	inhibit_apic_setting;				\=0D
-							\=0D
-	__test_x2apic_intercepts(use_evmcs);		\=0D
-} while (0)=0D
-=0D
-#define test_x2apic_intercepts(use_evmcs_setting)	\=0D
-do {							\=0D
-	bool use_evmcs_setting;				\=0D
-							\=0D
-	_test_x2apic_intercepts(inhibit_apicv =3D true);	\=0D
-	_test_x2apic_intercepts(inhibit_apicv =3D false);	\=0D
-} while (0)=0D
-=0D
-=0D
 int main(int argc, char *argv[])=0D
 {=0D
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX)=
);=0D
=0D
-	test_x2apic_intercepts(use_evmcs =3D false);=0D
+	test_x2apic_intercepts(true, false);=0D
+	test_x2apic_intercepts(false, false);=0D
=0D
-	if (kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))=0D
-		test_x2apic_intercepts(use_evmcs =3D true);=0D
+	if (kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS)) {=0D
+		test_x2apic_intercepts(true, true);=0D
+		test_x2apic_intercepts(false, true);=0D
+	}=0D
 }=0D
=0D
Paolo=0D

