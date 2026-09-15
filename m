Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A843BDAA
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=Jfzaa0CnsmO/yWnug5IQHDGiCGsV/12kNtTdHrRAgervjZ/peGR3+AJsUMgHSDjIqks6aOvSOmhBhj6bVIWofVtly56rpDtlis+INWB+nQ9kZFqsqa2KcOUCHUc+SJhEzGTHC4ttMbtZBy/Yxwakm05biFJpAktZpgEjBUAj+jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b917769so6935ad.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=UPTAtFTbgZqZuulbTL9AouuA0aQmwymHdtqAPNsc778GW4ZLjnsvMn6yH/H7bV76U3
         NyqcEU8JxhUrvvGLtVyWe18noGVh38mY5n6WXGNMQ9DddOuCOYpMk68083JSjN6Tpy9Z
         CdKU/6d6gsIgn+B7S8nm3WvxUGPtMWzNLZ4cj68OPOCHQmNqAZUzK1uhRnH9imbqviO0
         ChD0l1+z2XxvBMR2+WTrh/ZDbHDCC3tZaoWGMCwvUVbnfNxESuRbAoL/nzkpwDMm/ZUX
         3fwGMZFUVqjmoy34sjlA0G5gKKMMSLh8Eob5ZZRaW1lFGwy3j6XTAtkUMp8WScMH+HW4
         KJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=HPzLBlbNahfWq5+T7+8OfhB90I031ToR1FjzFRJb0qw=;
        b=mNVD3KYvPvM0M4kYA1QVx885uoPbXwxjNgjD3ymQb0fKBFD5BZeSnDcOGZCuZ6v4lK
         qT9yY+qNMcHVuN0Wbqhvmqu3K//gKOeHjsQZNSz6SsURziWBiyJOpYTjrLcwYjnSXnGY
         2RddWCdEERD+sz7hB9ZhMArxzTkBNlyBcOaSEH5gogjFsoPs/+RVNkSfrz9z+qZxh+85
         VuQIJfjMzs2qYCRjmbdtDP5NFV09gmrs8rHXvhCY5BS/G2x6Owx5ERcJX+vARFjdYeLs
         m+YXVqGI4VsbIORoxMZLB9lbsDhnpeM0my000Tpxs/Amjv/FoIpPUhGiEieX9JVgAhKt
         AwwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=iT403As7nKXTKD2LdR5MwHUAZUBsSOzYy6WSed/JBupL/D1HompB+FZSPJ2CsQQlQk
         a6H5tp1alAvpALM97djeZIHLL9gtLbO6gRMM17Q85I2SLG+5V0IWrFtX4RXijwKykmN6
         GiT8e8HwmgqJrmWNlFT2aTQzQ7ruafDqnppDpQ7d3/6l7gtJMx6L2DS9Sq+oIsJzZ/xR
         JXDT9GVDSr0OzNokAl3thqzTCf4pzstHt15rEJolnRFHtCubdRmzBpma1jDE4GWz+D7r
         2LSD+8oUlUz1KS1dMjYE7ilwN5MaR6fSyqX8Xtvul/Mrj+nIqtw7YKSg3MBhu72WLM6s
         blqA==
X-Forwarded-Encrypted: i=1; AKwUvBzIhk2rzubDcmrq0nmwmePK71Wby+SbSi1eol157bLo+NcVIu+W1dNlYuw7McQp0Xgn7Bk=@vger.kernel.org
X-Gm-Message-State: AFuF++kSElvayO5a2b9RF5EC5be40JkOBLeExTdzPlnnC0DM9T0lXqjL
	saQxFLREtdtzGJgROk1hi8R4uS8MRhg44emAFHEoCvzPOWjnXgWvwK7IG1EBcKw1juDTTKSiiDd
	DR11F8Tl1wmoHxtD1jiQEAYI0nuZrtrAqgQzIF3nK
X-Gm-Gg: AYBFou1O/tXiDPGz3QxO6M5eaxF7tIzcAaSfigalzh6dD1A1NfbJ+/8U3x0xdT1qoHU
	IbBt42i03VFGkxXyj8x1CVUaYRaT1QkTicjfLWOi3fho5lpiNdGgiHB+zqIJYWqWLG4vML0pKY3
	YsgzaXeDrjjVmmRcns9JewvKVLRqypKsqiK3o+7wkxVTluSjEWLsks/TR49rlXXjrGLH/P8R0qe
	NY3QUEftMziRiSTTO1lxWW8qD3JJoo+JCcHv/qSQl669qF+5zIljnu2Ue40XvspJHlJvXg1yWyU
	qld4F7vI2j0HmrpbQCddmoCNM1PPLT1EECZvWG6iNOZbcKtw9ipURt/1JQQVccmqnIQ8YOH1LHe
	Ow3yvmBs3rQClbKsi+El9l8W8fL7xYeh4sBKKeB1Qk8oNkF6bJ6Y=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
