Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCD2D8DA8;
	Sat,  1 Aug 2026 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570316; cv=none; b=EGWhGX8JNhLwsXr902uqvcZ8jcbeux3ewqn6cyBLCfr4DmfYo3lWLUTxvkK29kWJhxtlcPnfW1hO8UIWzgDQzhFPtwahdZG3Kj/pCXtrUqoRSyZis6bfSuaTihIggz4gpLN74Qf1tXj2SU/RMieG+uRgUBtfokk7fnvlT/PF38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570316; c=relaxed/simple;
	bh=ex3g9iR6+UTMOjHzQ7dE9XpiBCPGbgpprn2i5Rw+Jlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0HGun5/1f+67TaLYMKeyBzpv6JBKxNQutvF1Pw4ZTZyysOsmh7z4EhMytNPuXEv3tdzto0+ylaZNUJwhLG5jK7pGpL0vOcRKsRySHbflEC3vEm3PzUbUNQu49NRg3xSmOkXYxmNWFYU6fBTYfxFZPp2o91W3hUt/UCPhA7LUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=nvGPB1NH; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="nvGPB1NH"
Received: from x1 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6716iLcA026040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 1 Aug 2026 15:44:21 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=5aPRqBqevdyaIQe2OceZTahoSE455JINz5qEKLMWBmA=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1785566661; v=1;
        b=nvGPB1NHJwFVmNsvibfWy0837mYLKY8VZDIQ7TtTztPNZuVNhoi7JiRDKJtSN3rN
         TLHVuPqQk53h+WtCLEx1KmKbQR9vKRJ0LeemvyIWCjkvAAKA9Ckxgjq5kKtZy7Tv
         HY9jHIY2osO2LniuEz1xb9hTAUa/4F/K/7xYD8MGsc0ns3Q62eLfQvfKdJaNzaKF
         /0+QMKJZ0qJhoy3E8iWDg3h1ywZyUs7ut7nz+qMAHiRPDFLAoYJ0T6QRItg+pQaM
         SLsP0FzS78jrYUxeIJrE07RvjE4JGOCGftcgO88KBin1jCX9OgAqUkNqx+97Lc1o
         92dV9GruogoRDqlkaSMlHw==
From: Kohei Enju <kohei@enjuk.jp>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH] docs: KVM: fix heading level for KVM_S390_VM_CPU_PROCESSOR
Date: Sat,  1 Aug 2026 15:44:08 +0900
Message-ID: <20260801064414.23747-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the section title underline from '=' to '-' so that the attribute
is at the same heading level as the other attributes.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 Documentation/virt/kvm/devices/vm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/vm.rst b/Documentation/virt/kvm/devices/vm.rst
index a4d39fa1b083..71ab1351ad27 100644
--- a/Documentation/virt/kvm/devices/vm.rst
+++ b/Documentation/virt/kvm/devices/vm.rst
@@ -77,7 +77,7 @@ Allows user space to retrieve machine and kvm specific cpu related information::
 	    0 in case of success.
 
 2.2. ATTRIBUTE: KVM_S390_VM_CPU_PROCESSOR (r/w)
-===============================================
+-----------------------------------------------
 
 Allows user space to retrieve or request to change cpu related information for a vcpu::
 
-- 
2.55.0

