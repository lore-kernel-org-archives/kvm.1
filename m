Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D2224E4C2
	for <kvm@vger.kernel.org>; Tue, 11 Feb 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293470; cv=none; b=MzDTSDSYJuSOPQqoy6GgBQ74uoLN1XRuFyqF8I509Q4ixQ8bQrmT5VzSxfvrHs7vcLuFAoBxUVaOIt+ac4jgxti0pRoDpsn+H+SGaRlnrKVKQhQF21Y1L1vhEZ0IQ0uxIOnYlcfhzAUMdiGV1kNUoRGxo6jP6NfZCMTf2flRu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293470; c=relaxed/simple;
	bh=yXuW7zUnvHlzOOotF0GeoQkPeB+ZEDc7Qef52fgkXd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q/1XkV06IURn8B1Um65M57N1/q+IqyED+FjPzRVgVfdpgNkNR2IYO9rHWHQJFCZDFRWvDhffNbq+2xzadaz2QrBqJ9k05tckM5Yb8Ng2vcqogPWOdr9KKNsO6g4gIjnScTvFkn9jUnda/LOHUUFP9wf+pD0Yhzr1gPZdZdxnpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diDWKWzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diDWKWzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244CC4CEDD;
	Tue, 11 Feb 2025 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739293469;
	bh=yXuW7zUnvHlzOOotF0GeoQkPeB+ZEDc7Qef52fgkXd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=diDWKWzEzXPCsYgQqP/TTgdklkGeFX5xuQiyu3s4zAX6XaHKKMZaCULf+jTYU/xNw
	 tPlwsWh2nQS61Yu81obsZlb9oHfBf8S16cSlgUPZJTjDcyAkkDkXvV1BybLDVy+24C
	 ZHBOI75yEsw3/JRlKiaKcTELPYXG9MLZU2ozxMYW4ASI2AP7iSCLDUphTHMGr+SZ9W
	 YsZcieDoYwds0/lis0C1CSt1UalBf/em5XPNhMBHAjolVYDE+YLOIAF3E1vHL473Ay
	 Zu+mbQ4bJ7oWmz65cY1bpCHYvHG1VnWo3F4QnVLTQwhZXNKxGddWuKvRBClUuV7weh
	 G5fXwFROmWcuA==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: kvm@vger.kernel.org, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH kvmtool 1/2] cpu: vmexit: Handle KVM_EXIT_UNKNOWN exit
 reason correctly
In-Reply-To: <Z6s+s4hCZwoR8uod@arm.com>
References: <20250211073852.571625-1-aneesh.kumar@kernel.org>
 <Z6s+s4hCZwoR8uod@arm.com>
Date: Tue, 11 Feb 2025 22:34:23 +0530
Message-ID: <yq5ao6z8wgyw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi,
>
> On Tue, Feb 11, 2025 at 01:08:51PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> The return value for the KVM_RUN ioctl is confusing and has led to
>> errors in different kernel exit handlers. A return value of 0 indicates
>> a return to the VMM, whereas a return value of 1 indicates resuming
>> execution in the guest. Some handlers mistakenly return 0 to force a
>> return to the guest.
>
> I find this paragraph confusing. KVM_RUN, as per the documentation, returns 0 or
> -1 (on error). As far as I can tell, at least on arm64, KVM_RUN can never return
> 1.
>
> Are you referring to the loop in kvm_arch_vcpu_ioctl_run() by any chance? That's
> the only place I found where a value of 1 from the handlers signifies return to
> the guest.
>

Yes. I will update the commit message to reflect that. It is the exit
handler return value rather than KVM_RUN ioctl return value.

>
>> 
>> This worked in kvmtool because the exit_reason defaulted to
>> 0 (KVM_EXIT_UNKNOWN), and kvmtool did not error out on an unknown exit
>> reason. However, forcing a KVM panic on an unknown exit reason would
>> help catch these bugs early.
>
> I would hope that a VMM cannot force KVM to panic at will, which will bring down
> the host. Are you referring to kvmtool exiting with an error? That's what the
> unfortunately named 'panic_kvm' label seems to be doing.
>

yes. I will update the commit message to indicate that for
KVM_EXIT_UNKNOWN exit reason, kvmtool will now exit with an error
instead of returning to the guest."

-aneesh
