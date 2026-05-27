Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB73E9287
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886238; cv=none; b=fuEjep8rQjXz3ZaXMFTN76JtjWRtcat22FQwqt9i79TggCZYkuD2EcCnJtMrQgo8lmpjAuF/vN6duqqxKoWpo59/+OJklD2pS/YqRYaAFbLPBu2uUZL/P5ENLq2PILO/xqYruIs2M83r8eFzIjgV5Ab9/78N7T0kLPcCcjakZdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886238; c=relaxed/simple;
	bh=VZncZLZyzeZAaiIuhyjROvi6ztX3D3dqBhle8qaHB4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcxmQsIakKkIUGFk0LfnVgGZz16IZG/vE8w3lmPxzrDfj72UajHcnoMVPfnE0zagPhS34XzX6Nk7YGXU+CkAvCbB41mMQKuFUKP6RPn0qSXiLSx0aM2U54zti6ph0xuGKSCA/3YKXaKHq4/PzdsBBIx95QfBHajkNDfY0sCqOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXhqHpQH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXhqHpQH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd266f6fc0so57899295ad.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779886237; x=1780491037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFfUfVdymceQ6sN/zEMi68S56nOfGcMVCqg5DL2077Y=;
        b=KXhqHpQH/EuXmKA6+vgD5wBMDvE3PfzGJQNCi38lAOIOsgyFKOkm4Bg0zY6MSlIANg
         /gHLyUt+yF7DHa7y6Y6l1Iw/9DLFkl1Vqm1jh55hzbLcx7uvffjoNw6vKR33EMBlUcUR
         dZS23H4GMIm/yTaL9TG8Di1b2XyF6X9qZ+u7xyD8Y5/kkB7BEQoFstCeXUFIAm7vIML2
         z5rIeFsQUan8+W3GCLsC1vg6ISiMJNQw0UHBSgv3xsBWH0heE0YoOlxmeyw1ody2J4no
         ZxphVjdsATIEVoSj9/ozJuj7t/G1DimRiKIQIOA7AgibGoasad/VpQ0Nin4K3DHS3cs7
         XN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779886237; x=1780491037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFfUfVdymceQ6sN/zEMi68S56nOfGcMVCqg5DL2077Y=;
        b=NhVM9kHOJjv0Y/akVbKi52v6d/J3Jd/m24G86f1uULvas+SP7HyzrVTZG0qs6sp0fm
         XAjgqJBbz+TE8pR+zImrar9ctIqIH2vubSvnGPH7HuJt9aQSKIzQVKnvdMma8jS72s37
         QY/pSMriBi5XHRg6p2CgGEGTCUIysDx/RRztXjzDTXS98RdYjURLARsapOClSAAO6Rs5
         TmqgIWnxYTuaZsPQngXbKWVFnwji9HpJovcroamzNGu/BTOtKr2s+0Q/9tbv69djZkBY
         tX8p7gkt8i22fmt8fvkvqJXlM+laHpyyN5E+FQlk81Gdkqz8pOzZ+7MYaPDslKaTxDZT
         H/zA==
X-Gm-Message-State: AOJu0YxabqdgsxLkXQTHWpp+kNlMBxIzLlVtifg6fW3VA6Lvu18nkMy1
	jbqmDymsQiqPwx8+RiFZ/sT2ghbwqKMihBhFEHHffYlK0LZ7LdU+Ty7Jk2lefw==
X-Gm-Gg: Acq92OGXojneMjz/nP8iNwMLieFpFWSXLY8E0+ryf+7kwg1GD+zacG7pn+MhNng4A/D
	weLMcIfe69O7grP0wIqR4xlPNacw46P0kU3y36TKf6yaVQ45Wq4LxhiDYGbX7vuaIFCS7qSEcE5
	TKmsrx9diOd/LOvMyZIcBtWkpPXt2t9akwXjPGuCxeZnp7oZFahyqxq8LVGRPtKKCJFzInwspIL
	hEk1N+u5YmMz++jWvGvYyr584RVsEiNax6OakBbvZ/6vKjbLQmZUZKTUxsc1e5NO+UZ+7l3n46F
	uLK2sL4yy/CycJr9+uVEaCvM3ldxcZlyDQ1lowjwh1XjhW3Z0+LN9beVHPJ60SNh6+3mzpcVpxX
	yHQpVAH+MydsUO4ngS4iFEVabnMUZNZIFDYsGSS0VJB6UZnnJW3HFDEjruWHpVlwKC5fV9xUa05
	AQCIaBwZLeWm2yUtJt1wkU2IOFbL5Kkt2u+5dfamc=
X-Received: by 2002:a17:903:2f89:b0:2b0:ccad:de1a with SMTP id d9443c01a7336-2beb06bc100mr254327575ad.30.1779886236651;
        Wed, 27 May 2026 05:50:36 -0700 (PDT)
Received: from Mac.ibm.com ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c69a0sm151851185ad.59.2026.05.27.05.50.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 May 2026 05:50:36 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v3 05/10] KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
Date: Wed, 27 May 2026 18:19:54 +0530
Message-ID: <c99d0f7a08dd0ffff355d9a8a3cafbdb58ae646a.1779885589.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779885589.git.ritesh.list@gmail.com>
References: <cover.1779885589.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
debug purposes.
This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
as NR_CPUS of the host.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e00a25f59416..6319e2037882 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	vcpu->vm = vm;
 	vcpu->id = vcpu_id;
 	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+	if (vcpu->fd < 0) {
+		int saved_errno = errno;
+
+		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
+			vcpu_id, saved_errno);
+		errno = saved_errno;
+	}
 	TEST_ASSERT_VM_VCPU_IOCTL(vcpu->fd >= 0, KVM_CREATE_VCPU, vcpu->fd, vm);
 
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
-- 
2.39.5

