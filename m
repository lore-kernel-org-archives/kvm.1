Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769723E0230
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943705; cv=none; b=HnuGfndt1aUrbY8BQzJzh4eo0r1L2vlg1Du/CC/WJzW3kG6Ydxns0Uveghkwk8skfSIOhXCOSMRryYOm2bLxlmEAPl081kHXCCKwxVQ/yBruVeocmKRV+/9PTHPCFsx+cp4f7UAhff71l1otiMCPpgZ6IRFy5+P+Cgvf6NpbcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943705; c=relaxed/simple;
	bh=r2+oNhkrnpn5ngF8fEc+4WdZgag6SVn6RSHoepvTgx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nVVpMavyRUFVoIfOagPOAB19X9DWoaljUclwvd/uxUTtHxzQ6YhNL/u8HbnvZ7rYleBUv4YFBv5rLVCiwkegJUrOuspXxUrNoTX4nEVyhc/qhAxwWy5cX9te6fmbmfnEDh1zypT4VwNB7bgZ5Jx5pk4MAO4MghgbtHUitiwhcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUmH/iSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUmH/iSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E2C1F00898;
	Mon,  8 Jun 2026 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780943704;
	bh=UbxvpfcNZOOIpQl5Lh0YL1YR8/s6HFNthZP1+XyluTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KUmH/iSv97dfGfUZLGfQwV/O5UfQ8wWblVsHRL8STTQfQUQAamDV0qIo6SwEULh9t
	 SisbYzPHChK38wRf9Tbf5vr+V6HJ5neA+51czGW5ZsuDha4gVMp5kjMsgww9nj4gPX
	 GDHlhuGtvZwYMzNI8ixuPJy9OPWMebN+31rX23q36vpk1Yieb9neY9+AZgOVkLYsaK
	 vA8OfwLOplQkohCU/N7fgpDMJu3pbodi8zHK1H/y9LCMdKL6VHxTzB1kOciTk7RtAn
	 D4ruiRTTfZeecRbJv/5OH1ecir/tvsD9QDcxgjYawKZyO/RN1amblJJt1QexOeVC24
	 QOk5DH9o2Fosg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 35/60] kvm: Add VCPU plane-scheduling state and helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-36-joro@8bytes.org>
References: <20260608144252.351443-36-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:35:03 +0000
Message-Id: <20260608183504.23E2C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Error path during secondary VCPU creation destroys shared stru=
cture, causing Use-After-Free.
- [High] Missing IPI kick to the active VCPU prevents prompt preemption dur=
ing plane switch.
- [High] Unhandled KVM_REQ_PLANE_RESCHED request causes infinite vCPU loop.
- [High] Concurrent VCPU creation bypasses ID checks, allowing unprivileged=
 userspace to trigger a host DoS via WARN_ON_ONCE.
- [High] Non-atomic state transitions in plane switching result in state co=
rruption and force plane 0 to execute.
--

commit 1f17dacf62458889297d745dc273354c7b7cb798
Author: Joerg Roedel <joerg.roedel@amd.com>

KVM: Plane switching algorithm implementation

This commit introduces the algorithm to run the lowest runnable plane.
It implements plane switches by stopping the current plane and setting
another to runnable, adding state tracking and requests to manage this.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 5c3f9dfa15ea..e3611e6cc3e4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -168,6 +168,7 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
>  #define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_UNBLOCK			2
>  #define KVM_REQ_DIRTY_RING_SOFT_FULL	3
> +#define KVM_REQ_PLANE_RESCHED		4

[Severity: High]
This patch adds KVM_REQ_PLANE_RESCHED and asserts it via kvm_make_request(),
but is there a corresponding handler to process and clear this request?

Without a call to kvm_clear_request(), the bit remains permanently set.
Could this cause kvm_request_pending() to perpetually return true,
forcing the VCPU to endlessly abort guest entry and spin in a soft lockup?

[ ... ]

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9d30fd85ce5f..a30123b77112 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4397,6 +4397,7 @@ static int kvm_plane_ioctl_create_vcpu(struct kvm_p=
lane *plane, unsigned long id
>  	vcpu->vcpu_idx =3D vcpu->common->vcpu_idx;
>  	vcpu->plane =3D plane;
>  	vcpu->plane_level =3D plane->level;
> +	vcpu->plane_state =3D STOPPED;
>  	vcpu->run =3D vcpu->common->run;
> =20
>  	kvm_vcpu_init(vcpu, kvm, id);

[Severity: High]
Can a concurrent VCPU creation bypass the ID checks in this function?

Looking at kvm_plane_ioctl_create_vcpu(), the plane_get_vcpu_by_id() check
is performed locklessly before acquiring kvm->lock:

	r =3D -EEXIST;
	if (plane_get_vcpu_by_id(plane, id))
		goto vcpu_free;

	...
	mutex_lock(&kvm->lock);
	r =3D xa_insert(&plane->vcpu_array, vcpu->vcpu_idx, vcpu, ...);
	WARN_ON_ONCE(r =3D=3D -EBUSY);

If a malicious userspace process concurrently creates multiple VCPUs with t=
he
same ID, could multiple threads pass the existence check?

When they subsequently acquire the lock to insert into the xarray, the
second thread would receive -EBUSY and hit the WARN_ON_ONCE(r =3D=3D -EBUSY)
inside the lock. Could this regression allow unprivileged userspace to trig=
ger
a host denial-of-service if panic_on_warn is set?

[Severity: Critical]
Does the error path for secondary VCPU creation safely handle the shared
common structure?

When creating a secondary VCPU, it inherits the common state from the plane=
 0
VCPU:

	vcpu->common =3D vcpu_plane0->common;

If a subsequent step like kvm_arch_vcpu_create() fails, the error path jumps
to vcpu_free_common, which unconditionally executes
kvm_vcpu_common_destroy(vcpu):

vcpu_free_common:
	kvm_vcpu_common_destroy(vcpu);

Because this destruction logic does not verify whether the common struct
is exclusively owned by the failing VCPU, could it destroy the shared
structure while the plane 0 VCPU is still actively using it, resulting
in a use-after-free and state corruption for the primary plane?

[ ... ]

> @@ -4938,6 +4939,50 @@ static struct file_operations kvm_plane_fops =3D {
>  	KVM_COMPAT(kvm_plane_ioctl),
>  };
> =20
> +void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->plane_state =3D RUNNABLE;
> +	vcpu->common->plane_switch =3D true;
> +	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_runnable);

[Severity: High]
Is this request being sent to the correct VCPU?

When switching planes, KVM_REQ_PLANE_RESCHED is sent to the target vcpu.
Because the target VCPU is often inactive (in the STOPPED state, not loaded
on a physical CPU, and not in guest mode), kvm_vcpu_kick() will not issue
an IPI.

Will this prevent the currently running VCPU (vcpu->common->current_vcpu)
from being promptly preempted, allowing it to continue executing until an
unrelated VM exit occurs?

[ ... ]

> +struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_vcpu_common *common =3D vcpu->common;
> +	struct kvm_vcpu *ret =3D NULL;
> +	unsigned i;
> +
> +	for (i =3D 0; i < KVM_MAX_PLANES; i++) {
> +		if (common->vcpus[i] =3D=3D NULL)
> +			continue;
> +
> +		if (common->vcpus[i]->plane_state =3D=3D RUNNABLE) {
> +			ret =3D common->vcpus[i];
> +			break;
> +		}
> +	}
> +
> +	if (ret =3D=3D NULL) {
> +		ret =3D common->vcpus[0];
> +		ret->plane_state =3D RUNNABLE;
> +	}

[Severity: High]
Could this fallback resurrect plane 0 during an in-progress plane switch?

Plane switching involves independent calls to kvm_vcpu_set_plane_stopped(ol=
d)
and kvm_vcpu_set_plane_runnable(new). This non-atomic sequence creates a ra=
ce
window where all planes temporarily appear STOPPED.

If kvm_vcpu_select_plane() runs during this window, this fallback logic
forces plane 0 to RUNNABLE. When the target plane is subsequently marked
runnable by the transitioning thread, both plane 0 and the target plane
are RUNNABLE.

Because select_plane() always selects the lowest index, will this trap the
VCPU on plane 0 and defeat the intended switch to the higher plane?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D35
