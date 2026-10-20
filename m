Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502094;
	b=1EjotYs7dWyUq/YETt9Xtzn3I5mQzNVnydFFe4Yj5Ee/xoPKCc69cMoesWBRhMY71aVb
	 u7FAqGGLCKCB+E6K3BQ0nVcTKlVjPLwjCj5svO1iVXqFAFc3xdUWbMSQggGSfbTb4ayhq
	 xdEV+glqkcTh1SGIP79Q6Gpt0T+stbvkf13xIJSGMp7H48q9WNDzk9njGzzPXuu43wxxT
	 ru6tuXHcdZ1+mfOJMnKIxrQPjF9ketO6wWS5MArRJztI7LDcDVTMPaq5igbU/IlFmFIRD
	 +YizpbRarkxRn5uMMlSrvafhuGzBamto/FMEtQDT4HE3pcywD3+7njOsUu+Hwkm6ocg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502094;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=bw4lYiwjLEPSm4Dy3CtJY5F6jT11MLgP2bjSbOIY7js=;
	b=iFNp/HXbpRnV8VabPhC78janrjNySL4G1uD85tuTBDCiNTtLDYtMfbP6TOuwhutjnJRr
	 vIORMVGUDhRF1mHIVVPPlBBOq1RYPmYw5t0uGwI4Pb4ubXvIzMvqhgefHnxpI3KO7IJMd
	 70pdwSk8bRq5nZ8UnmjapCiazH1vOsRwqtO0QCCO49LikfT7mBJ4L+FLz7QrX+4BqwzHe
	 8z1VCR25UZNXMiBInAq1fzwRUOwDbYCSmus4vUaxu74uaZaEHDKPhjKIWqLAtnZsIGzTG
	 kLzM8l5ZnHOPC3nu/1RNmSA1kD5uzInxhkGX5SrVi++QwPbBJoLNRBjKNgLCoOjzEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQfBz5TY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F959606A32E
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 13:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F959606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQfBz5TY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792502093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bw4lYiwjLEPSm4Dy3CtJY5F6jT11MLgP2bjSbOIY7js=;
	b=fQfBz5TYmfFHaObO1YblreUJ3tviHfOqDpNISxvfShqE7y+4ZbRDlL7jB8QuEWj2HorwSF
	pyjrPPCZv2pGYVjkaeYUjcVMhTppaejDC7sxo2fn7BBfNRXG0TZ3l3qkS/tTq6o2tUuDfH
	+zeYmmEJ0AUX/4tw53q+1HAF3gnKhYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-8WFv5sO-MNiInMcxl51rGA-1; Tue,
 20 Oct 2026 09:14:51 -0400
X-MC-Unique: 8WFv5sO-MNiInMcxl51rGA-1
X-Mimecast-MFC-AGG-ID: 8WFv5sO-MNiInMcxl51rGA_1792502089
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 947AC1956040;
	Tue, 20 Oct 2026 13:14:49 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 528C418005B7;
	Tue, 20 Oct 2026 13:14:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Ackerley Tng <ackerleytng@google.com>,
	Fuad Tabba <tabba@google.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Shivank Garg <shivankg@amd.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 0/3] KVM: Kconfig fixes for the VM-wide private memory attribute
Date: Tue, 20 Oct 2026 09:14:44 -0400
Message-ID: <20261020131447.122096-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A late review of the guest_memfd attributes changes...

With Linux 7.4 the "private" memory attribute was moved from the VM
to the individual guest_memfd file descriptor.  The old semantics are
available for backwards compatibility via CONFIG_KVM_VM_MEMORY_ATTRIBUTES,
and disabled by default.

This change has two problems: first, it ties support for VM memory
attributes entirely to a backwards compatibility symbol for distros.
Second, it is incompatible with all released versions of QEMU (and
perhaps most other VMMs?), thus the default is arguably not the
right one.

Fix the first problem, by making CONFIG_KVM_VM_MEMORY_ATTRIBUTES an
internal configuration symbol that is the equivalent of the old
CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES, and use a more descriptive name
for the private memory attribute.  Fix the second by changing the
default to y if either SEV or TDX are enabled; leaving it n for
CONFIG_KVM_SW_PROTECTED_VM as it is only useful for selftests.

The last patch is a simple code cleanup to remove the static call
and module parameter overhead when the VM-level attribute is absent.

Thanks,

Paolo

Paolo Bonzini (3):
  KVM: split CONFIG_KVM_PRIVATE_MEMATTR_VM out of
    KVM_VM_MEMORY_ATTRIBUTES
  KVM: x86: leave the legacy private attribute in for TDX and SEV
  KVM: compile out all !gmem_in_place_conversion code unless
    CONFIG_KVM_PRIVATE_MEMATTR_VM

 Documentation/admin-guide/kernel-parameters.txt |  4 ++--
 arch/x86/kvm/Kconfig                            |  6 ++++--
 include/linux/kvm_host.h                        | 13 ++++++-------
 virt/kvm/Kconfig                                |  3 +++
 virt/kvm/kvm_main.c                             | 15 ++++++++-------
 5 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.52.0

