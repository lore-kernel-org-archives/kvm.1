Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14125B0BF
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616746; cv=none; b=np9kFbqz+cM0yMW3ifMT98qcpY2uPC3UZJQjq/Y4+DAkBNCJAT1/oBsmGRoxyfc4VIKVnukICsyMkXM5v5/DZO8IiLGNVVQ6scPK5ZPElZGzVba0H4jHrKyYxlqWL6goCjKAxHAIv8hd+bIuGaTAOMwKAtwg0okUEIhxmmc9CeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616746; c=relaxed/simple;
	bh=HHhg2hoL7//TkwvoJEz8hezfEMP5OMKKOP5cqLRFNs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4WE0Ne5sMiFL50CxTfWLJoKC/auarCs6ocP+LZtuz7hEdyij51lEu7kRrzErwJIf5uRhuWrrF9PahJ3ZeO7jbv05/YjFaqGGixZ3Q4oycJgBs28KsSNdGRwgAAq3mhkBJK8D5JHONcazBAZrFaCFe6ra9qZtY3v3EDvpnupuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdvrNUo9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONB+bgxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdvrNUo9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONB+bgxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778616744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Cayd8zbVawoYaZdVzFtXrH2LL1XTq+yqD6VwGGwDvs=;
	b=WdvrNUo9eR2h3K0UtDOOQJVWoUpsd5CjOwIg/9YbVw21WqwAexCCu2TgnUjTuGdzahpxaN
	gg8n4mLaFv1R2drACCRADMTPfIX3+eD1B3mGbywWfPXkI/QOCZmMrkyvHs2G9fOvqng1El
	d2BsU3Two7TYVQcu1w3nltPKF28sEx0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-WAzzbViXM9Syf3uOWZw8LA-1; Tue, 12 May 2026 16:12:23 -0400
X-MC-Unique: WAzzbViXM9Syf3uOWZw8LA-1
X-Mimecast-MFC-AGG-ID: WAzzbViXM9Syf3uOWZw8LA_1778616742
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso38043855e9.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778616742; x=1779221542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Cayd8zbVawoYaZdVzFtXrH2LL1XTq+yqD6VwGGwDvs=;
        b=ONB+bgxX8xwtMsr6W6IZDTjYhjJXQ8/sGxzFcVTqr8JQ5umycfkPudAm56vRGUsbA8
         JloxBeTsEcZMkRCZ/FFaWv6IwzUxVVH7JVOPa2pNa3lLSqH2eeUeJYI0hQwXfTTNOXWn
         4C47jIO5ZsnvBRTSd4PlUa4CVtmx03JJDBxLWh/hj4BhzPp9ru6i285ll8sg7A/AnF9t
         cYS307UoGyRByHPSzumDzcZYRJIAeYhjeaJMpeMue5xDjAHSF/ndCbmfCHX65hjYKwQ2
         YxphXgbenqRR0lIjmc5o2MSAysPEff5Eiv49NTC/kJITOOhRERgx/UlALwX9irZeO6OM
         ge+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616742; x=1779221542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Cayd8zbVawoYaZdVzFtXrH2LL1XTq+yqD6VwGGwDvs=;
        b=maDRscT+0uWz0vyUKUH9H1SDPrHgKChUL8RxfR1xoOr56lfEwtqblcLpEA/uNYN72I
         AGB1Oh1mWSwhrR0yAvbwWuv0HvKY10HE3ESFeI28H+2EMSvn76c8XC+UWU0AeM5Iradq
         lXrGNBQzb/UyLMAhHsot9/JSCTXud2e8QcnbD78wpoTqJQ5jDzY1ToUmZdkbBOt4G1uR
         9N2jom/Lh1eldvhsJl509esAUt5rLLNSNrpoOPof4INtDScut3gnCzo5mGY2O+WYYIrE
         e/uQqNIuQwo7Max4C9lvx0r2xzNOYgPq6RWDWToilOJVs2u+kRI3oy1yPn73tVLgCo+K
         KV8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ocGOmKKJjTLW1KrsAjYJpm5DCunWPs8YHqIHwOkf7xq5suhFCwlvZ0ldCcjvbbgVhffQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxzPyMq/lxR4Vv8OxHQYEIPQPqI3vhIY7rbuBsu0zjWbmejgC
	6Iy3KKNv4P3cInVqqjaWGE/6SJpkVjz7RfbZDTL3gCOdgqL6Dx1D5APhmq3IXPtD3W1vfWaryDj
	Hm/d9xJo1aeaudLTQQHulvbcCwRSS6oA0daLp8+yLriUDJNSS1d9Img==
X-Gm-Gg: Acq92OHAl4MHMyJxEnRRkevXo5Eodto0frLZRuNk4HKGY3ZimRXzvP3elLBEf7ivczy
	Htsa3vg/g7lFwXJ19zrnoOKAgQ6C/kGad9Lx1Fr72ZQsjsFrBCcroZM7+yTOagq1wraPvHWOSaa
	5XmlJ0w5NYzYvmVYOaR65sRbIiv6vrfaTqFGkdt+SWMxORb6xe80Jig2xVXbWhhWRfY5KPo+uJz
	liHv19nhn8gped3aI9wf5ZG8Q0tzfye4Ic8RdmUQplS5MAVuPb+mN0G624m+fkLS/wwK+4eW6Xh
	Qd6NNfuj6gjEgnxWLryIK5Xj1lMnCBSKLgFb+UBX+qHJ1s7zSfnr+PLkTC1wKRhFdtc5oaLeKwX
	/h8UxnVsfJp/hrwZwWe5z+W/+nkJxoW8kCgOAYI8XXrC3Bza/XHOG1Geco+m9qnHPHZHXLXkxeX
	9NpSFlo/3vgS621gaD9fwSjjW9FU6E
X-Received: by 2002:a05:600c:4fc9:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48fc9a029a2mr4635725e9.3.1778616741855;
        Tue, 12 May 2026 13:12:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:48a:52d4:888c with SMTP id 5b1f17b1804b1-48fc9a029a2mr4635555e9.3.1778616741369;
        Tue, 12 May 2026 13:12:21 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e4bbebdsm38633856f8f.5.2026.05.12.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:12:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: yosry@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>,
	David Kaplan <david.kaplan@amd.com>
Subject: [PATCH v2] KVM: nSVM: Never use L0's PAUSE loop exiting while L2 is running
Date: Tue, 12 May 2026 22:12:19 +0200
Message-ID: <20260512201219.3021354-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508213321.373309-1-seanjc@google.com>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 5/8/26 23:33, Sean Christopherson wrote:=0D
> Never use L0's (KVM's) PAUSE loop exiting controls while L2 is running,=0D
> and instead always configure vmcb02 according to L1's exact capabilities=
=0D
> and desires.=0D
=0D
Queued, thanks.  While I didn't go as far as splitting in two commits,=0D
I did apply a more or less cosmetic tweak to the WARNs.  Calling=0D
grow_ple_window/shrink_ple_window with PLE disabled is harmless but=0D
also makes little sense.  This can be represented by a WARN that=0D
does not have an early return.=0D
=0D
The WARN condition is obviously false for shrink_ple_window and=0D
a little less obviously so for grow_ple_window, but in case any=0D
other callers are added it can be useful to have it as a heads up.=0D
=0D
Paolo=0D
=0D
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c=0D
index ac21f402c1ca..e02a38da5296 100644=0D
--- a/arch/x86/kvm/svm/svm.c=0D
+++ b/arch/x86/kvm/svm/svm.c=0D
@@ -913,12 +913,15 @@ static void grow_ple_window(struct kvm_vcpu *vcpu)=0D
 	struct vmcb_control_area *control =3D &svm->vmcb->control;=0D
 	int old =3D control->pause_filter_count;=0D
=0D
+	/* Adjusting pause_filter_count makes no sense if PLE is disabled.  */=0D
+	WARN_ON_ONCE(kvm_pause_in_guest(vcpu->kvm));=0D
+=0D
 	/*=0D
 	 * While running L2, KVM should intercept PAUSE if and only if L1 wants=0D
 	 * to intercept PAUSE, and L1's intercept should take priority, i.e.=0D
 	 * KVM should never handle a PAUSE intercept from L2.=0D
 	 */=0D
-	if (WARN_ON_ONCE(is_guest_mode(vcpu) || kvm_pause_in_guest(vcpu->kvm)))=0D
+	if (WARN_ON_ONCE(is_guest_mode(vcpu)))=0D
 		return;=0D
=0D
 	control->pause_filter_count =3D __grow_ple_window(old,=0D
(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]? y=0D
@@ -939,6 +942,9 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)=0D
 	struct vmcb_control_area *control =3D &svm->vmcb->control;=0D
 	int old =3D control->pause_filter_count;=0D
=0D
+	/* Adjusting pause_filter_count makes no sense if PLE is disabled.  */=0D
+	WARN_ON_ONCE(kvm_pause_in_guest(vcpu->kvm));=0D
+=0D
 	if (is_guest_mode(vcpu))=0D
 		return;=0D
=0D
=0D
=0D

