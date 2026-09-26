Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EB1B3B19
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403104; cv=none; b=QO8iEuam4auODoBsLXot0yQi9IISW+ZiymyIkHkpa0UEWD1upjiAj2kb+ZHuA+cXZRrciWVw9BwGMKI+kZEM+dWxMj+qCVrUKbLfvAN6ZW3/4EBZVN7ouvS0q9tt3NFAnX3HBszPCYglprbWTyKTiob3cKaWBiH3JFIE7hQT0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403104; c=relaxed/simple;
	bh=aMAVCwYAzwgjRTTqaVNCL6KskGTUJHm3j8ZOolxqAAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2z5JOoOE2PDCphDzLm4ZsVod+hbbVw42ko1/xw4KBa6GHWMHMs1wUvXom1Wn+KPXZqbyL74VWTs4UIqGFaHaWZqYf9dAGZYe2QyYFTDU1P7sWPw8UR/1NweL4ZCVHNeAb4JHLiuAItRog+aC7YTKSIINe8PgXlfb/Pes+aF7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsKzxQIW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fADPd94d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsKzxQIW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fADPd94d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790403101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
	b=QsKzxQIWbXqgQ/Sdv7GzboL4uacK4Rnec6JjrTQ4jSj0kfg3Hv94Z5W1+4CBpiea3ls/d/
	tDs2WcotpCYi1wMMzzVllRDQ9TirCdVmWYs1WPhB4m0QTWJpf2xpwpzS8UcJlMvpxO7Xe7
	xHDmOt61vZBr2+s02RAMtaLs7g4HTdg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-x7dYwFHKP3a3ROHJmB4W2A-1; Sat, 26 Sep 2026 02:11:39 -0400
X-MC-Unique: x7dYwFHKP3a3ROHJmB4W2A-1
X-Mimecast-MFC-AGG-ID: x7dYwFHKP3a3ROHJmB4W2A_1790403098
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso17782015e9.1
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790403098; x=1791007898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
        b=fADPd94dDYoLt7vOFkr6Znp287dzdXlRlmG2CJwBJXFNyF/0u+y30OmpAfypU7F3YN
         TaFh0tZFlsgQcxcFvnlwP/OpIjJDuydDXzbefB9CdozhcsNoVJvhDqxHc4F4OH1huOSb
         C1xR6jo0TVQ3uPJTtuKUJfcU3eE2vdPMOwT2jpRn3aTtbOMwEwc+cO+NJogfNfS1tYmK
         2AOx0338oUVp7gjyeqigVtAsZhbN7tw7tzthlCqOfyeUcdpcAfDOk4yInVRpPy5ab+ZQ
         R3eL9O/fvK5IDMubAoOA6LcufsMlQOjm9g31yi+d2pY7v5PuchVBrYX9XXSMFBW4YvDP
         Fclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403098; x=1791007898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o1xKo46sR3x0JxHMDQkcV1eouqIgMqjiPh6siPlWkc0=;
        b=VHaHikYSk8PNmWRxBo1pqJlusCYz916g4c/h784Rdkth65ISb5rvv1Gk47AQGq3ezt
         9bbjLnoUsXnZrDYtkAka+yILjMd9/vFkDOIGHe5uayKFy/Ev+RXbSZkvQUMtXVtxZBiB
         iPLOqsPafPqsMTrC+Hg7BMiVQ6+LWRAhpnkaSP/fCGJbTuIpn82qX3d/gveVOyyz2pXM
         jx0mra7ImBwROdOAsPkKLwaEFO6WyjxZjOY878RlkToKV9wEMbbEvkZLn19vf/lf9D1C
         3in4xvQW95G9oSpvTrLvM6G1lGO38cjb/FrG0VPP/shKsk/C+hrLP11zYXM83ZbO6ytO
         mMqA==
X-Forwarded-Encrypted: i=1; AKwUvByRoEZ0byrbq6//bwWXM2tcFz2s41YlmdVYyjlb/VL19nQapdWlDysi7PugDEIEUAPErxw=@vger.kernel.org
X-Gm-Message-State: AFuF++mcu14dFxmGBXcdihPswf6LeKTZGdIYz7qAENfvk9aIYWt+ZuMB
	xTMIrPFTj1eYvF/y9x6tuJehdf8QWiVE7QKyG/qSgOqWa5e8ggF1PEfZV1LgBh9nPG9oh2tMVl4
	YDKlZwiP1RoyABc/Od0wi/96bTaFfhxeJYU4lM42NqwC0MeEFEgz4WTI3ViL4Yw==
X-Gm-Gg: AYBFou0Q1/itBRr/NpAeVmzum3VYVLuMPy5pTVKoqUKSztiMEJRASo5sAVwVxgMNU0O
	+cvdQkruY4Fugr41ZOPTIA35678CuoxME0MzEsfetzgLwmDO0dWZ8F8nJ4FoN3u7+9A78nDU5G9
	mpPg38pK6eMHD9S7vFcqmDJacQH9zb8UCWH0CL8w2ks/ntXQKw19dsVqilHClsOdsHqDs5UcuKD
	4FB4pW8Z2YZARWsWMxiOdnA2vfE38LDQhDLnpW70PMabXyuC76bioBlb4Dhb7pGuPwJoawv0lfR
	7ptuWZYf1EGxPIKzvgutqkNX2roX0GzRGeMRKbUkXQsCJPANAlEOIGyMWcOAaXGfxMr7dG3dOCD
	9UASfPKkLpXQh/UBrTJ1ZtsTjP4hmT1Gv1fJzoCtT/moXC7ksfP9iXK7cHPavD3VwibBT8tD4N6
	WzORjB
X-Received: by 2002:a05:600c:4f83:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-49ffdcac67dmr5718395e9.12.1790403098306;
        Fri, 25 Sep 2026 23:11:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4f83:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-49ffdcac67dmr5718175e9.12.1790403098002;
        Fri, 25 Sep 2026 23:11:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm293694945e9.14.2026.09.25.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:11:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: Re: [PATCH 00/11] KVM: fix issues with stale control fields
Date: Sat, 26 Sep 2026 08:11:35 +0200
Message-ID: <20260926061135.714158-1-pbonzini@redhat.com>
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

