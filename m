Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC152D6E64
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848590; cv=none; b=r+YnAOc2AcySqG/20JOpBZOvAdJctdbij8IW+dzAqEDzkEwqDA3ZuxV+c9DveK10u2R/LnLwYujGul6idRLkuD6Xq51ctOECvkUKhK+h5rVIooB5ghctwtqZKw2bJ1hJzNNPbErd4wXxrlCGyisA0NLEW1Oy+qtiJKM0HLhPWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848590; c=relaxed/simple;
	bh=SnukTocrydn2EMeQtcL652lg+gVPW95N6YW2SJ8ne80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trgQO0A5v41IkF3C4Lo+Wt2H/Aj5yVyHdR8W5Lc+o56Afgbd5zGIKeMnto+tSW/AqfdyhRWTXxnqj/72Dxfjw9aFGLsTZ/3r5oRjT3csEDbcromwfKYE7S7pfNzX4urCQgDY2WWTzN7vg2WqL5kRh+9uiS2YGE9iu/9sc/nEbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QY9YTKOA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QY9YTKOA"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36641fe4aedso21394951a91.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779848588; x=1780453388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHGGuPHnrHr96ZnKnHIAvteciA3tSFbnEMO+mwXnDlQ=;
        b=QY9YTKOAEedoM93sKk9koA+TYdzYzxovxSpBdrRgeIpmXLresnLDKX2gGDDIlSsGFc
         cI02SWRpKbG7IBthnPA6HnJOaJjDPYYc7oAFkfJNHGtU/HJl43yh2Ovb189QP5c34gqK
         0VEQ1QBLhsGoMQxKyrFoCFVvURvY6XaO6nyWzsC7xPHZkkrq37P9tLj2AodytUu9eLvH
         R8KtwggWAp7cxB2l7H4tnyKampv2qM7AMH/IvXZQpVbTT2x0mmvedJT5/DdBoIDVmf59
         i37vkOh4GhVE+UdyuX51Zp1VHQf9IRgrHnwMkMtmTEabj7C1yBOvV6yCKH/+dIuaMQSW
         8mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779848588; x=1780453388;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aHGGuPHnrHr96ZnKnHIAvteciA3tSFbnEMO+mwXnDlQ=;
        b=jgoCvwF8RNoPHB1GaeX7Wz503JBPMMAzxkHKU99qnV+0buAs+OpfkxElEOSp+ikLub
         LXPLA1eZww9t9lrisJzaCAg5rQK5ouZhpgTGh9w48+LZjlrqZKqZEwytpylfjOC9j/MV
         hF+cLZS3LRKwlcHQGEjHdLzWzzlpgaiyk9Gm5hUxcF6RrKDaHnFiwGofZm6HyWgghQYF
         wyMssh+EFLycTSDjAirb9uuG2B6w22X1+maEYq0B+IWQ+z4OzBNsxFsHe1nRmSAN885h
         l2EzgfmBNl98MP6MaEqH1rtaAkfvbDmjZof0RpKK4yW0H+nHl7wnkmnqXLQhSbnVUA27
         YRdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8y/nO5ZzT+ZUN0AqNJwzdFE92Ui3laORG1i9X9EzoeNUy55kpOgOU1d8jbeBd8VOVC4SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/aiAP0Or7IwAcDKe1KJVT2zPI2NjOpBfCoS9nDbT8pL/ifs6
	heyFpwBZDAHLhYtkHwzu8rmU3+zVRMeLLGXadjq5T/3BvcMa/4yVRr45ZkTN27UaVCYGYFOmGGa
	wLmlSTw==
X-Received: from pgbcf1.prod.google.com ([2002:a05:6a02:841:b0:c79:8fde:6559])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:164a:b0:3a2:bd1d:d679
 with SMTP id adf61e73a8af0-3b328fd02e8mr22273010637.48.1779848588186; Tue, 26
 May 2026 19:23:08 -0700 (PDT)
Date: Tue, 26 May 2026 19:23:07 -0700
In-Reply-To: <20260421231557.1254270-14-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-14-jrhilke@google.com>
Message-ID: <ahZVi0njg6j38Q2f@google.com>
Subject: Re: [PATCH v3 13/16] KVM: selftests: Verify vCPU migration during IRQ delivery
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Josh Hilke wrote:
> From: David Matlack <dmatlack@google.com>
>=20
> Add the '-m' flag to irq_test to migrate vCPU threads across random
> physical CPUs during the test. This validates KVM's ability to handle
> vCPUs changing physical CPUs while interrupts are actively being
> injected.
>=20
> To support this, add wrappers for gettid() and sched_getaffinity(), and
> introduce pin_task_to_random_cpu() in lib/kvm_util.c.
>=20
> Co-developed-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../selftests/kvm/include/kvm_syscalls.h      |  6 ++++
>  .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
>  tools/testing/selftests/kvm/irq_test.c        | 34 +++++++++++++++++--
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +++++++++++
>  4 files changed, 59 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/t=
esting/selftests/kvm/include/kvm_syscalls.h
> index d4e613162bba..d73f45c5df92 100644
> --- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
> +++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
> @@ -73,9 +73,15 @@ static inline int kvm_dup(int fd)
>  	return new_fd;
>  }
> =20
> +static inline int gettid(void)

gettid() already exists in at least some of my environments:

include/kvm_syscalls.h:87:19: error: static declaration of =E2=80=98gettid=
=E2=80=99 follows non-static declaration
   87 | static inline int gettid(void)
      |                   ^~~~~~
In file included from /usr/include/unistd.h:1221,
                 from /usr/include/x86_64-linux-gnu/bits/sigstksz.h:24,
                 from /usr/include/signal.h:328,
                 from include/test_util.h:12,
                 from lib/kvm_util.c:7:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous decla=
ration of =E2=80=98gettid=E2=80=99 with type =E2=80=98__pid_t(void)=E2=80=
=99 {aka =E2=80=98int(void)=E2=80=99}
   34 | extern __pid_t gettid (void) __THROW;
      |                ^~~~~~

> +void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
> +{
> +	int i =3D 0, nr_cpus =3D CPU_COUNT(possible_cpus);
> +	int cpu, target_idx;
> +
> +	target_idx =3D kvm_random_u64(&kvm_rng) % nr_cpus;
> +
> +	for (cpu =3D 0; i < nr_cpus; cpu++) {

Shouldn't this be bounded on "cpu < nr_cpus"?  If 'i' gets to nr_cpus, it m=
eans
"i =3D=3D target_idx" was never taken.  And at that point, the loop will ha=
ng
indefinitely because cpu will likely be waaaay out of bounds of possible_cp=
us,
i.e. the loop will always continue.

> +		if (!CPU_ISSET(cpu, possible_cpus))
> +			continue;
> +
> +		if (i =3D=3D target_idx) {
> +			pin_task_to_cpu(task, cpu);
> +			return;
> +		}
> +		i++;
> +	}

This should TEST_FAIL().  Or maybe "break" on the match, and the assert tha=
t
i =3D=3D target_idx?

> +}
> +
>  void kvm_parse_vcpu_pinning(const char *pcpus_string, uint32_t vcpu_to_p=
cpu[],
>  			    int nr_vcpus)
>  {
> --=20
> 2.54.0.rc2.533.g4f5dca5207-goog
>=20
