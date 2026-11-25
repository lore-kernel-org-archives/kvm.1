Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618363;
	b=Ud/2fGeiPL9xw21U2utm42i508L9/I8vDsmjvRHyPNiFEpYAJTpkz3xYq3QWte8CYRFu
	 vcsVilAptD/lpRRWWmtnQzdBhtipo2ukG33k/gMMq6LdU13dWlJGIg13E9EIlD6ouzjvA
	 1MjJ0vYlqwJ9MiL1geBILiu08rNc5Gevplf3aXfz4iQMSTUiu68orgzrzE3eviF3kzdKF
	 IK6QEkL7FIpwvbXaLbYuT4UuB9MBl4G8IZRC4dcQLP5Cj2OGreLxWNYZhjnhu+NHZcf3O
	 6pb4QVdPSi5wlz6lQAJi+jdBjoI8fFvV11P9uNHbIEsEP+iw/WVjryOMVBDC+vpFtYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618363;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=I65+VEvzVyiDB8Ux80AgMibeLNzhCOGIyd4dmoeqaKI=;
	b=2v8cB04UFZKjVBX1thZ3eYa3XLQaJfUG/U5ZUY/9kJQ+1Bpivcf1TmXsZXjA+uMvKFto
	 CCT1T4d3jRoR6ptvQc4Px1IMaQunI1kGgLTXz4H1MiIRfcV8XwxA+LNDGlDZJXmQqycEW
	 i7cUTikoeXmBoDUHRKiqw46+fq986W+AMW+Oj/x9BCgkB1bEnla65Lzo8UTBJorB62Gca
	 vf8pstsow/yPeUMUuFTHYscjNnSpSyB/W+y76VRjEjUuLlGCMHu4qUXTo8QBnjk1+u/3m
	 UO6r3HcK73e6HFn2sXaym8OoEG4c5BMlBhGt67DL5MEFKheMffSjkpRKTRVOfpUHCDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D6TOgCA8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E269606A329
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E269606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D6TOgCA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795618362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I65+VEvzVyiDB8Ux80AgMibeLNzhCOGIyd4dmoeqaKI=;
	b=D6TOgCA8OKWaIserxeD8PHoSTLohCHdGNRD/uLoBwx1lbZV8X3N3ggAVVpacci4+XJneXs
	TQX7lcZi8OZ6taB300rqbMLxnGcKKKt1hWj4NdzbwfhYorz3N/Gg9pHLQXyMjJoT8X8VUv
	usZHzK2LBic79OVO5U2We0dQNGEKg2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-vxFIpNWPM3i9wZ88PNjioA-1; Wed,
 25 Nov 2026 14:52:37 +0000
X-MC-Unique: vxFIpNWPM3i9wZ88PNjioA-1
X-Mimecast-MFC-AGG-ID: vxFIpNWPM3i9wZ88PNjioA_1795618356
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22C2B1800365;
	Wed, 25 Nov 2026 14:52:36 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 058C81800550;
	Wed, 25 Nov 2026 14:52:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org,
	Jeremiah McReynolds <jmcrey@google.com>
Cc: seanjc@google.com
Subject: Re: [kvm-unit-tests PATCH] x86/msr: Disable PMU for MSR tests
Date: Wed, 25 Nov 2026 15:52:33 +0100
Message-ID: <20261125145233.1892656-1-pbonzini@redhat.com>
In-Reply-To: <20260917172651.3322899-1-jmcrey@google.com>
References: <20260917172651.3322899-1-jmcrey@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, 17 Sep 2026 17:26:51 +0000, Jeremiah McReynolds wrote:
> QEMUv11 introduced a check when PMU is enabled to ensure that the
> virtualized CPU is the same as the underlying host CPU[1]. The MSR test
> always runs under GenuineIntel with the max CPU model, so PMU is
> implicitly enabled. However, when run on AMD, this new check in QEMU
> causes the test to fail with the log: "host doesn't support requested
> feature: vPMU".
>
> Explicitly disable PMU on the MSR test to avoid this failure.
>
> [1]: https://gitlab.com/qemu-project/qemu/-/commit/4c7f05232cd1db5db114d36be2b210d24f1b9ad3
>
> Signed-off-by: Jeremiah McReynolds <jmcrey@google.com>

Applied, thanks.

> ---
>  x86/unittests.cfg | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index ae731a93..06fe92f9 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -174,9 +174,10 @@ arch = x86_64
>  # Use GenuineIntel to ensure SYSENTER MSRs are fully preserved, and to test
>  # SVM emulation of Intel CPU behavior.  Use the max CPU model so that 64-bit
>  # support follows the host kernel.  Running a 32-bit guest on a 64-bit host
> -# will fail due to shortcomings in KVM.
> +# will fail due to shortcomings in KVM.  The max CPU model turns on PMU, but
> +# Intel PMU registers cannot be virtualized on AMD, so turn it off.
>  file = msr.flat
> -qemu_params = -cpu max,vendor=GenuineIntel
> +qemu_params = -cpu max,vendor=GenuineIntel,pmu=off
>  
>  [msr64]
>  # Same as above, but with a minimal 64-bit CPU model to validate cases where an
> -- 
> 2.55.0.1082.g2b9226bbc0-goog

